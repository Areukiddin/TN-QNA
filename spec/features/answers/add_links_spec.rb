feature 'User can add links to answer', %(
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:gist_url) { 'https://gist.github.com/Areukiddin/e1d816a72cd8984cb9a6858a194b764e' }

  scenario 'User adds link when answer question', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'Question answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end
end
