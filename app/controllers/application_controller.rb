class ApplicationController < ActionController::API

  private

  def command_bus
    Rails.configuration.command_bus
  end

  def projects_read_model
    @projects_read_model ||= ProjectsReadModel.new
  end
end
