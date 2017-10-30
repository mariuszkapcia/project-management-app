class AssignmentsController < ApplicationController
  def create
    render json: {}, status: :no_content
  end
end
