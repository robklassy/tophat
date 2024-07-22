class CoursesController < ApplicationController

  def index
    @courses = Course.all
    render json: @courses, status: :ok
  end

  def show
    @course = Course.find_by(id: params[:id])
    render json: @course, status: :ok
  end

end
