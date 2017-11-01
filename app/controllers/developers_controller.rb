class DevelopersController < ApplicationController
  def index
    render json: [], status: :ok
  end

  def create
    head :created
  end
end
