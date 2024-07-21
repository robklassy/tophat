class AddUserTypeToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :discussion_question_posts, :user_type, :string, null: false
  end
end
