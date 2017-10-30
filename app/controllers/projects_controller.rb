class ProjectsController < ApplicationController
  def create
    command_bus.call(register_project)

    head :created
  end

  private

  def register_project
    Assignments::RegisterProject.new(params[:uuid], params[:name])
  end
end
