class DevelopersController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: UI::DeveloperListReadModel.new.all, status: :ok
      end
      format.html do
        render action: :index, locals: { developers: UI::DeveloperListReadModel.new.all }
      end
    end
  end

  def new
    developer_uuid = SecureRandom.uuid

    render action: :new, locals: { developer_uuid: developer_uuid }
  end

  def create
    ProjectManagement::DevelopersCommandHandler
      .new(event_store: event_store)
      .call(register_developer)

    respond_to do |format|
      format.json do
        head :created
      end
      format.html do
        redirect_to developers_path, notice: 'Developer has been added successfully.'
      end
    end
  end

  private

  def register_developer
    ProjectManagement::RegisterDeveloper.new(
      uuid:     params[:uuid],
      fullname: params[:fullname],
      email:    params[:email]
    )
  end

  def event_store
    Rails.configuration.event_store
  end
end
