class WelcomeController < ApplicationController
  def index
    render action: :index, locals: {}
  end
end
