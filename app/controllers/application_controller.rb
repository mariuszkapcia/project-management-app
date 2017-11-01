class ApplicationController < ActionController::API

  private

  def command_bus
    Rails.configuration.command_bus
  end
end
