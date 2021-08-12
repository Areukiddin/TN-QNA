feature 'Author can destroy own answers', %q{
  In order to control own activity
  As an authenticated user
  I'd like to be able to destroy own answers
} do

  given(:answer_own) { create(:answer) }
  given(:answer_foreign) { create(:answer) }

  context 'Authenticated user tries to destroy' do
    background { sign_in(answer_own.author) }

    scenario 'own answer' do
      visit question_path(answer_own.question)

      click_on 'Delete answer'

      expect(page).to have_content "Answer was successfully deleted."
      expect(page.find_all('p.answer').count).to eq 0
    end

    scenario 'another answer' do
      visit question_path(answer_foreign.question)

      click_on 'Delete answer'

      expect(page.find_all('p.answer').count).to eq 1
      expect(page).to have_content "You can't delete this answer, because you are not an author."
    end
  end

    scenario 'Unuthenticated user can not delete answer' do
      visit question_path(answer_foreign.question)

      expect(page).to_not have_link 'Delete answer'
    end
end
