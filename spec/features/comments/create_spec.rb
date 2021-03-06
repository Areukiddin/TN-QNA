feature 'User can comment the resource', "
  In order to give feedback
  As an authenticated user
  I'd like to be able comment a resources
" do
  given!(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    given(:user) { create(:user) }

    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'add comment to the question' do
      expect(page).not_to have_content 'Test comment'

      within '.new-comment' do
        fill_in 'Comment', with: 'Test comment'
        click_on 'Comment'
      end

      expect(page).to have_content 'Your comment successfully posted.'
      expect(page).to have_content 'Test comment'
    end

    scenario 'answer the question with errors' do
      within '.new-comment' do
        click_on 'Comment'
      end

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'multiple sessions' do
    given(:user) { create(:user) }

    scenario 'comment add to question and appears on another users page', :js do
      Capybara.using_session('user') do
        sign_in(user)

        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)

        expect(page).not_to have_content 'Test comment'
      end

      Capybara.using_session('user') do
        within '.new-comment' do
          fill_in 'Comment', with: 'Test comment'

          click_on 'Comment'
        end

        expect(page).to have_content 'Test comment'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Test comment'
      end
    end
  end

  scenario 'unauthenticated user tries to comment the question', :js do
    visit question_path(question)

    expect(page).not_to have_link 'Comment'
  end
end
