class AddUserTypeToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussion_questions, :user_type, :string, null: false
  end
end
