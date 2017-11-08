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

  def assign_developer
    command_bus.call(assign_developer_to_project)

    head :no_content
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

  def assign_developer_to_project
    developer = DevelopersReadModel.new.find(params[:developer_uuid])

    ProjectManagement::AssignDeveloperToProject.new(
      project_uuid:       params[:uuid],
      developer_uuid:     params[:developer_uuid],
      developer_fullname: developer.fullname
    )
  end
end
