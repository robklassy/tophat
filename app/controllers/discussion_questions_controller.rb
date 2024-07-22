class DiscussionQuestionsController < ApplicationController
  def index
    @dqs = if params['course_id']
      DiscussionQuestion.where(course_id: params['course_id']).all
    else
      DiscussionQuestion.all
    end

    render json: @dqs, status: :ok
  end

  def show
    qry = if params['course_id']
      DiscussionQuestion.where(course_id: params['course_id'])
    else
      DiscussionQuestion
    end

    @dq = qry.where(id: params['id']).first

    render json: @dq, status: :ok
  end

  def create
    params.permit!
    @dq = DiscussionQuestion.new(params['discussion_question'])
    @dq.save!

    render json: @dq, status: :ok
  end

  def update
    params.permit!
    @dq = DiscussionQuestion.find_by(id: params['id'])
    @dq.update!(params['discussion_question'])

    render json: @dq, status: :ok
  end

  def destroy
    @dq = DiscussionQuestion.find_by(id: params[:id])
    @dq.deleted_at = Time.zone.now
    @dq.save!

    render json: @dq, status: :ok
  end
end
