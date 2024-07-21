class DiscussionQuestionRating < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :discussion_question

  validates :user_type, exclusion: { in: ['User'],
    message: "%{value} is not allowed" }
end
