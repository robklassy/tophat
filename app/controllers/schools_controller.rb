class SchoolsController < ApplicationController

  def index
    @schools = School.all
    render json: @schools, status: :ok
  end

  def show
    @school = School.find_by(id: params[:id])
    render json: @school, status: :ok
  end

end