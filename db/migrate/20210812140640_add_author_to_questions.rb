class AddAuthorToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :author, null: false, index: true
  end
end
