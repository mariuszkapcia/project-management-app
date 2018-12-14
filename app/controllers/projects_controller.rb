class ProjectsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: UI::ProjectListReadModel.new.all, status: :ok }
      format.html { render action: :index, locals: { projects: UI::ProjectListReadModel.new.all } }
    end
  end

  def show
    render json: UI::ProjectDetailsReadModel.new.find(params[:id]), status: :ok
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

  def assign_working_hours
    ProjectManagement::ProjectsCommandHandler
      .new(event_store: event_store)
      .call(assign_working_hours_to_project)

    head :no_content
  end

  def assign_deadline
    ProjectManagement::ProjectsCommandHandler
      .new(event_store: event_store)
      .call(assign_deadline_to_project)

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
      uuid:  params[:id],
      hours: params[:hours].to_i
    )
  end

  def assign_developer_to_project
    developer = UI::DeveloperListReadModel.new.find(params[:developer_uuid])

    ProjectManagement::AssignDeveloperToProject.new(
      project_uuid:       params[:id],
      developer_uuid:     params[:developer_uuid],
      developer_fullname: developer.fullname
    )
  end

  def assign_working_hours_to_project
    ProjectManagement::AssignDeveloperWorkingHours.new(
      project_uuid:   params[:id],
      developer_uuid: params[:developer_uuid],
      hours_per_week: params[:hours_per_week].to_i
    )
  end

  def assign_deadline_to_project
    ProjectManagement::AssignDeadline.new(
      project_uuid: params[:id],
      deadline:     params[:deadline].to_i
    )
  end

  def event_store
    Rails.configuration.event_store
  end
end
