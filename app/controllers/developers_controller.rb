class DevelopersController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: UI::DeveloperListReadModel.new.all, status: :ok }
      format.html { render action: :index, locals: { developers: UI::DeveloperListReadModel.new.all } }
    end
  end

  def new
    developer_uuid = SecureRandom.uuid

    respond_to do |format|
      format.html { render action: :new, locals: { developer_uuid: developer_uuid } }
    end
  end

  def create
    respond_to do |format|
      begin
        ProjectManagement::DevelopersCommandHandler
          .new(event_store: event_store)
          .call(register_developer)

        format.json { head :created }
        format.html { redirect_to developers_path, notice: 'Developer has been added successfully.' }
      rescue ProjectManagement::Developer::EmailAddressNotUniq => exception
        format.json { render_error(:email_address_not_uniq, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(:email_address_not_uniq)
          render action: :new, locals: { developer_uuid: params[:uuid], errors: [error] }
        end
      rescue Command::ValidationError => exception
        format.json { render_error(exception.message, :unprocessable_entity) }
        format.html do
          error = ErrorHandler.json_for(exception.message)
          render action: :new, locals: { developer_uuid: params[:uuid], errors: [error] }
        end
      end
    end
  end

  private

  def register_developer
    ProjectManagement::RegisterDeveloper.new(
      developer_uuid: params[:uuid],
      fullname:       params[:fullname],
      email:          params[:email]
    )
  end

  def event_store
    Rails.configuration.event_store
  end
end
