class DiscussionQuestionPost < ApplicationRecord
  belongs_to :course
  belongs_to :user, polymorphic: true
  belongs_to :discussion_question_post, optional: true
  belongs_to :discussion_question

  has_many :discussion_question_posts

  validates :user_type, exclusion: { in: ['User'],
    message: "%{value} is not allowed" }

    after_save :bust_cache

  def self.traverse_child_posts(posts)
    h = {}

    posts.each do |p|
      h[p.id] ||= {}
      h[p.id]['parent'] ||= p
      h[p.id]['children'] ||= self.traverse_child_posts(p.discussion_question_posts)
    end

    h
  end

  def self.discussion_question_posts_tree(posts)
    root_posts = posts.select { |p| p.discussion_question_post_id.blank? }
    h = traverse_child_posts(root_posts)
    h
  end

  def bust_cache
    # need to bust the tree cache if a post for this course and discussion question is saved
    key = "th-#{course_id}-#{discussion_question_id}"
    DiscussionQuestionPost.redis_connection.del(key)
  end

  def self.redis_connection
    redis ||= Redis.new
  end
end
