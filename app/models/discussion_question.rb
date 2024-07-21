class DiscussionQuestion < ApplicationRecord
  belongs_to :course
  belongs_to :user, polymorphic: true

  has_many :discussion_question_posts

  validates :user_type, exclusion: { in: ['User'],
    message: "%{value} is not allowed" }
  
  def discussion_question_posts_tree(start_time: nil, end_time: nil)
    # generate the tree here
  end  
end
