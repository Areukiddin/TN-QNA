feature 'User can add links to question', %(
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
) do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/Areukiddin/e1d816a72cd8984cb9a6858a194b764e' }
  given(:google_url) { 'https://google.ru' }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit new_question_path
    end
    scenario 'User adds several links when asks question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: gist_url
      click_on 'add link'

      within '.nested-fields' do
        fill_in 'Link name', with: 'google'
        fill_in 'Url', with: google_url
      end

      click_on 'Ask'

      visit current_path

      expect(page).to have_content 'test'
      expect(page).to have_content 'gistfile1.txt'
      expect(page).to have_content 'test'

      expect(page).to have_link 'google', href: google_url
    end
  end
end
