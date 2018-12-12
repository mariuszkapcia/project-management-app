class DevelopersController < ApplicationController
  def index
    render json: UI::DeveloperListReadModel.new.all, status: :ok
  end

  def create
    ProjectManagement::DevelopersCommandHandler
      .new(event_store: event_store)
      .call(register_developer)

    head :created
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
