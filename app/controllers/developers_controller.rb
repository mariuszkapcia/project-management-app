class DevelopersController < ApplicationController
  def index
    render action: :index, locals: { developers: UI::DeveloperListReadModel.new.all }
  end

  def new
    developer_uuid = SecureRandom.uuid

    render action: :new, locals: { developer_uuid: developer_uuid }
  end

  def create
    ProjectManagement::DevelopersCommandHandler
      .new(event_store: event_store)
      .call(register_developer)

    redirect_to developers_path, notice: 'Developer has been added successfully.'
  end

  private

  def register_developer
    ProjectManagement::RegisterDeveloper.new(
      uuid:     params[:developer_uuid],
      fullname: params[:fullname],
      email:    params[:email]
    )
  end

  def event_store
    Rails.configuration.event_store
  end
end
