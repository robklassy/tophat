class DiscussionQuestionPost < ApplicationRecord
  belongs_to :course
  belongs_to :user, polymorphic: true
  belongs_to :discusstion_question_post
  belongs_to :discussion_question

  validates :user_type, exclusion: { in: ['User'],
    message: "%{value} is not allowed" }
end
