class ProjectsController < ApplicationController
  def index
    render json: UI::ProjectListReadModel.new.all, status: :ok
  end

  def show
    render json: UI::ProjectDetailsReadModel.new.find(params[:uuid]), status: :ok
  end

  def create
    ProjectManagement::ProjectsCommandHandler
      .new(event_store: event_store)
      .call(register_project)

    head :created
  end

  def estimate
    ProjectManagement::ProjectsCommandHandler
      .new(event_store: event_store)
      .call(estimate_project)

    head :no_content
  end

  def assign_developer
    ProjectManagement::ProjectsCommandHandler
      .new(event_store: event_store)
      .call(assign_developer_to_project)

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
      hours: params[:hours].to_i
    )
  end

  def assign_developer_to_project
    developer = UI::DeveloperListReadModel.new.find(params[:developer_uuid])

    ProjectManagement::AssignDeveloperToProject.new(
      project_uuid:       params[:uuid],
      developer_uuid:     params[:developer_uuid],
      developer_fullname: developer.fullname
    )
  end

  def event_store
    Rails.configuration.event_store
  end
end
