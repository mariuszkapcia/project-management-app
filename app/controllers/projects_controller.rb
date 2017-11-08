class ProjectsController < ApplicationController
  def index
    render json: ProjectsReadModel.new.all, status: :ok
  end

  def show
    render json: ProjectDetailsReadModel.new.find(params[:uuid]), status: :ok
  end

  def create
    command_bus.call(register_project)

    head :created
  end

  def estimate
    command_bus.call(estimate_project)

    head :ok
  end

  private

  def register_project
    ProjectManagement::RegisterProject.new(
      uuid: params[:uuid],
      name: params[:name]
    )
  end

  def estimate_project
    ProjectManagement::EstimateProject.new(
      uuid:  params[:uuid],
      hours: params[:hours]
    )
  end
end
