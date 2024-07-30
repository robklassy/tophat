class DiscussionQuestionPostsController < ApplicationController
  def index
    key = "th-#{params['course_id']}-#{params['discussion_question_id']}"

    # see if this is cached if its the tree structure
    if params['hierarchy'] == 'tree' && params['course_id'].present? && params['discussion_question_id'].present?
      cached = DiscussionQuestionPost.redis_connection.get(key)
      if cached.present?
        @dqps = JSON.parse(cached)
        render json: @dqps, status: :ok
        return
      end
    end

    qry = DiscussionQuestionPost

    if params['course_id'].present?
      qry = qry.where(course_id: params['course_id'])
    end

    if params['discussion_question_id'].present?
      qry = qry.where(discussion_question_id: params['discussion_question_id'])
    end

    flat_dqps = qry.all

    @dqps = if params['hierarchy'] == 'tree'
      res = DiscussionQuestionPost.discussion_question_posts_tree(flat_dqps)
      # cache this tree result for speed
      DiscussionQuestionPost.redis_connection.set(key, res.to_json, ex: 360)
      res
    else
      flat_dqps
    end

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
    increment = 0

    if rating.blank?
      rating = DiscussionQuestionPostRating.new(
        user_id: params['user_id'],
        user_type: params['user_type'],
        discussion_question_post_id: @dqp.id,
        liked: true
      )
      rating.save!
      increment = 1
    else
      if !rating.liked?
        rating.liked = true
        rating.save!
        increment = 2
      end
    end

    if increment != 0
      @dqp.like_count += increment
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
    decrement = 0

    if rating.blank?
      rating = DiscussionQuestionPostRating.new(
        user_id: params['user_id'],
        user_type: params['user_type'],
        discussion_question_post_id: @dqp.id,
        liked: false
      )
      rating.save!
      decrement = -1
    else
      if rating.liked?
        rating.liked = false
        rating.save!
        decrement = -2
      end
    end

    if decrement != 0
      @dqp.like_count += decrement
      @dqp.save!
    end

    render json: @dqp, status: :ok
  end

  def cancel_rating
    params.permit!
    @dqp = DiscussionQuestionPost.find_by(id: params['id'])
    rating = DiscussionQuestionPostRating.find_by(
      user_id: params['user_id'],
      user_type: params['user_type'],
      discussion_question_post_id: @dqp.id
    )

    if rating.present?
      if rating.liked?
        @dqp.like_count -= 1
        @dqp.save!
      else
        @dqp.like_count += 1
        @dqp.save!
      end
    end

    render json: @dqp, status: :ok
  end

end
