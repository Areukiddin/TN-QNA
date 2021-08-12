feature 'Author can destroy own questions', %q{
  In order to control own activity
  As an authenticated user
  I'd like to be able to destroy own questions
} do

  given!(:question_own) { create(:question) }
  given!(:question_foreign) { create(:question) }

  context 'Authenticated user tries to destroy' do
    background { sign_in(question_own.author) }

    scenario 'own question' do
      visit question_path(question_own)
      click_on 'Delete'

      expect(page).to have_content "Question was successfully deleted."
      expect(page.find_all('li.question').count).to eq 1
    end

    scenario 'another question' do
      visit question_path(question_foreign)
      click_on 'Delete'

      expect(page).to have_content "You can't delete this question, because you are not an author."
      expect(page.find_all('li.question').count).to eq 2
    end
  end

    scenario 'Unuthenticated user can not delete question' do

      expect(page).to_not have_link 'Delete'
    end
end
