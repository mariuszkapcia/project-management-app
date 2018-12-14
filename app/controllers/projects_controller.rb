class ProjectsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: UI::ProjectListReadModel.new.all, status: :ok }
      format.html { render action: :index, locals: { projects: UI::ProjectListReadModel.new.all } }
    end
  end

  def new
    project_uuid = SecureRandom.uuid

    respond_to do |format|
      format.html { render action: :new, locals: { project_uuid: project_uuid } }
    end
  end

  def show
    project = UI::ProjectDetailsReadModel.new.find(params[:id])

    respond_to do |format|
      format.json { render json: project, status: :ok }
      format.html { render action: :show, locals: { project: project } }
    end
  end

  def create
    respond_to do |format|
      begin
        ProjectManagement::ProjectsCommandHandler
          .new(event_store: event_store)
          .call(register_project)

        format.json { head :created }
        format.html { redirect_to project_path(params[:uuid]), notice: 'Project has been added successfully.' }
      rescue Command::ValidationError => exception
        format.json { render_error(exception.message, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(exception.message)
          render action: :new, locals: { project_uuid: params[:uuid], errors: [error] }
        end
      end
    end
  end

  def new_estimation
    respond_to do |format|
      format.html { render action: :new_estimation, locals: { project_uuid: params[:id] } }
    end
  end

  def estimate
    respond_to do |format|
      begin
        ProjectManagement::ProjectsCommandHandler
          .new(event_store: event_store)
          .call(estimate_project)

        format.json { head :no_content }
        format.html { redirect_to project_path(params[:uuid]), notice: 'Project has been estimated successfully.' }
      rescue ProjectManagement::Project::InvalidEstimation => exception
        format.json { render_error(:invalid_estimation, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(:invalid_estimation)
          render action: :new_estimation, locals: { project_uuid: params[:uuid], errors: [error] }
        end
      rescue Command::ValidationError => exception
        format.json { render_error(exception.message, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(exception.message)
          render action: :new_estimation, locals: { project_uuid: params[:uuid], errors: [error] }
        end
      end
    end
  end

  def new_assignment
    developers = UI::DeveloperListReadModel.new.all

    respond_to do |format|
      format.html { render action: :new_assignment, locals: { project_uuid: params[:id], developers: developers } }
    end
  end

  def assign_developer
    respond_to do |format|
      begin
        ProjectManagement::ProjectsCommandHandler
          .new(event_store: event_store)
          .call(assign_developer_to_project)

        format.json { head :no_content }
        format.html { redirect_to project_path(params[:uuid]), notice: 'Develper has been assigned successfully.' }
      rescue ProjectManagement::Project::DeveloperAlreadyAssigned => exception
        developers = UI::DeveloperListReadModel.new.all

        format.json { render_error(:developer_already_assigned, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(:developer_already_assigned)
          render action: :new_assignment,
                 locals: { project_uuid: params[:uuid], developers: developers, errors: [error] }
        end
      end
    end
  end

  def new_weekly_hours_assignment
    respond_to do |format|
      format.html do
        render action: :new_weekly_hours_assignment,
               locals: { project_uuid: params[:id], developer_uuid: params[:developer_uuid] }
      end
    end
  end

  def assign_working_hours
    respond_to do |format|
      begin
        ProjectManagement::ProjectsCommandHandler
          .new(event_store: event_store)
          .call(assign_working_hours_to_project)

        format.json { head :no_content }
        format.html do
          redirect_to project_path(params[:uuid]), notice: 'Develper weekly hours has been assigned successfully.'
        end
      rescue ProjectManagement::Project::HoursPerWeekExceeded => exception
        format.json { render_error(:hours_per_week_exceeded, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(:hours_per_week_exceeded)
          render action: :new_weekly_hours_assignment,
                 locals: { project_uuid: params[:id], developer_uuid: params[:developer_uuid], errors: [error] }
        end
      rescue Command::ValidationError => exception
        format.json { render_error(exception.message, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(exception.message)
          render action: :new_weekly_hours_assignment,
                 locals: { project_uuid: params[:id], developer_uuid: params[:developer_uuid], errors: [error] }
        end
      end
    end
  end

  def new_deadline
    respond_to do |format|
      format.html { render action: :new_deadline, locals: { project_uuid: params[:id] } }
    end
  end

  def assign_deadline
    respond_to do |format|
      begin
        ProjectManagement::ProjectsCommandHandler
          .new(event_store: event_store)
          .call(assign_deadline_to_project)

        format.json { head :no_content }
        format.html { redirect_to project_path(params[:uuid]), notice: 'Deadline has been assigned successfully.' }
      rescue ProjectManagement::Project::DeadlineFromPast => exception
        format.json { render_error(:deadline_from_past, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(:deadline_from_past)
          render action: :new_deadline, locals: { project_uuid: params[:uuid], errors: [error] }
        end
      rescue Command::ValidationError => exception
        format.json { render_error(exception.message, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(exception.message)
          render action: :new_deadline, locals: { project_uuid: params[:uuid], errors: [error] }
        end
      end
    end
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
      hours: params[:hours].present? ? params[:hours].to_i : nil
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
      hours_per_week: params[:hours_per_week].present? ? params[:hours_per_week].to_i : nil
    )
  end

  def assign_deadline_to_project
    # NOTE: Convert deadline from web ui.
    if (Float(params[:deadline]) == nil rescue true)
      params[:deadline] = params[:deadline].to_datetime
    end

    ProjectManagement::AssignDeadline.new(
      project_uuid: params[:id],
      deadline:     params[:deadline].present? ? params[:deadline].to_i : nil
    )
  end

  def event_store
    Rails.configuration.event_store
  end
end
