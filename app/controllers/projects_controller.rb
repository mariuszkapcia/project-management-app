class ProjectsController < ApplicationController
  def index
    render json: projects_read_model.all, status: :ok
  end

  def create
    command_bus.call(register_project)

    head :created
  end

  private

  def register_project
    Assignments::RegisterProject.new(
      uuid: params[:uuid],
      name: params[:name]
    )
  end
end
