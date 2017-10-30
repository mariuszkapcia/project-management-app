class ProjectsController < ApplicationController
  def index
    render json: [], status: :ok
  end

  def create
    command_bus.call(register_project)

    head :created
  end

  private

  def register_project
    Assignments::RegisterProject.new(params[:uuid], params[:name])
  end
end
