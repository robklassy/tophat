class FacultiesController < ApplicationController

  def index
    @faculties = Faculty.all
    render json: @faculties, status: :ok
  end

  def show
    @faculty = Faculty.find_by(id: params[:id])
    render json: @faculty, status: :ok
  end

end
