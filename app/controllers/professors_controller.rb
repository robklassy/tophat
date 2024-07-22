class ProfessorsController < ApplicationController

  def index
    @profs = Professor.all
    render json: @profs, status: :ok
  end

  def show
    @prof = Professor.find_by(id: params[:id])
    render json: @prof, status: :ok
  end

end
