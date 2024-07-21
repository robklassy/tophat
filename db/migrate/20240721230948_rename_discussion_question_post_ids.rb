class RenameDiscussionQuestionPostIds < ActiveRecord::Migration[7.1]
  def change
    rename_column :discussion_question_posts, :discussion_question_posts_id, :discussion_question_post_id
  end
end
