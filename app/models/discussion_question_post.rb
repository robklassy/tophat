class DiscussionQuestionPost < ApplicationRecord
  belongs_to :course
  belongs_to :user, polymorphic: true
  belongs_to :discussion_question_post, optional: true
  belongs_to :discussion_question

  has_many :discussion_question_posts

  validates :user_type, exclusion: { in: ['User'],
    message: "%{value} is not allowed" }
end
