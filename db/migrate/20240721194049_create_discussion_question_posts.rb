class CreateDiscussionQuestionPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :discussion_question_posts, id: :uuid do |t|
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :user_type, null: false
      t.text :content
      t.datetime :posted_at
      t.datetime :archived_at
      t.datetime :deleted_at
      t.datetime :edited_at
      t.string :state
      t.integer :like_count
      t.references :discussion_question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_reference :discussion_question_posts, :discussion_question_posts, null: true, foreign_key: true, type: :uuid
  end
end
