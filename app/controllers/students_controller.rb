class StudentsController < ApplicationController

  def index
    @students = Student.all
    render json: @students, status: :ok
  end


  def show
    @student = Student.find_by(id: params[:id])
    render json: @student, status: :ok
  end

end
