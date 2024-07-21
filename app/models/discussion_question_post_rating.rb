class DiscussionQuestionPostRating < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :discussion_question_post

  validates :user_type, exclusion: { in: ['User'],
    message: "%{value} is not allowed" }
end
