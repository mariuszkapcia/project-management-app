class DevelopersController < ApplicationController
  def index
    render json: DevelopersReadModel.new.all, status: :ok
  end

  def create
    command_bus.call(register_developer)

    head :created
  end

  private

  def register_developer
    Assignments::RegisterDeveloper.new(
      uuid: params[:uuid],
      name: params[:name]
    )
  end
end
