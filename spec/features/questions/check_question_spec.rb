feature 'User can see questions list', %q{
  In order to find needed answer
  I'd like to be able to see questions list
} do

  given!(:questions) { create_list(:uniq_question, 3) }

  scenario 'User can see questions list' do
    visit root_path

    expect(page.find_all('li.question').count).to eq 3

    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

  scenario 'User can see question' do
    visit question_path(questions.last)

    expect(page).to have_content questions.last.title
    expect(page).to have_content questions.last.body
  end
end
