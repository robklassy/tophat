class DiscussionQuestionPostsController < ApplicationController
  def index
    # Redis cache here based on course_id and discussion_question_id

    qry = DiscussionQuestionPost

    if params['course_id'].present?
      qry = qry.where(course_id: params['course_id'])
    end

    if params['discussion_question_id'].present?
      qry = qry.where(discussion_question_id: params['discussion_question_id'])
    end

    flat_dqps = qry.all
    @dqps = DiscussionQuestionPost.discussion_question_posts_tree(flat_dqps)

    render json: @dqps, status: :ok
  end

  def show
    qry = DiscussionQuestionPost

    if params['course_id'].present?
      qry = qry.where(course_id: params['course_id'])
    end

    if params['discussion_question_id'].present?
      qry = qry.where(discussion_question_id: params['discussion_question_id'])
    end

    @dqp = qry.where(id: params['id']).first
    
    render json: @dqp, status: :ok
  end

  def create
    params.permit!
    @dqp = DiscussionQuestionPost.new(params['discussion_question_post'])
    @dqp.save!

    render json: @dqp, status: :ok
  end

  def update
    params.permit!
    @dqp = DiscussionQuestionPost.find_by(id: params['id'])
    @dqp.update(params['discussion_question_post'])
    @dqp.save!
    render json: @dqp, status: :ok
  end

  def destroy
    @dqp = DiscussionQuestionPost.find_by(id: params['id'])
    @dqp.deleted_at = Time.zone.now
    @dqp.save!
    render json: @dqp, status: :ok
  end

  def like
    params.permit!
    @dqp = DiscussionQuestionPost.find_by(id: params['id'])
    rating = DiscussionQuestionPostRating.find_by(
      user_id: params['user_id'],
      user_type: params['user_type'],
      discussion_question_post_id: @dqp.id
    )
    increment = false

    if rating.blank?
      rating = DiscussionQuestionPostRating.new(
        user_id: params['user_id'],
        user_type: params['user_type'],
        discussion_question_post_id: @dqp.id,
        liked: true
      )
      rating.save!
      increment = true
    else
      if !rating.liked?
        rating.liked = true
        rating.save!
        increment = true
      end
    end

    if increment
      @dqp.like_count ||= 0
      @dqp.like_count += 1
      @dqp.save!
    end

    render json: @dqp, status: :ok
  end

  def dislike
    params.permit!
    @dqp = DiscussionQuestionPost.find_by(id: params['id'])
    rating = DiscussionQuestionPostRating.find_by(
      user_id: params['user_id'],
      user_type: params['user_type'],
      discussion_question_post_id: @dqp.id
    )
    decrement = false

    if rating.blank?
      rating = DiscussionQuestionPostRating.new(
        user_id: params['user_id'],
        user_type: params['user_type'],
        discussion_question_post_id: @dqp.id,
        liked: false
      )
      rating.save!
      decrement = true
    else
      if rating.liked?
        rating.liked = false
        rating.save!
        decrement = true
      end
    end

    if decrement
      @dqp.like_count ||= 0
      @dqp.like_count -= 1
      @dqp.save!
    end

    render json: @dqp, status: :ok
  end
end