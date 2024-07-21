class CreateDiscussionQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :discussion_questions, id: :uuid do |t|
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :user_type, null: false
      t.string :title
      t.text :content
      t.datetime :posted_at
      t.datetime :archived_at
      t.datetime :deleted_at
      t.datetime :edited_at
      t.string :state

      t.timestamps
    end
  end
end
