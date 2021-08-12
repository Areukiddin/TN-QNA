class AddAuthorToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :author, null: false, index: true
  end
end
