require 'rails_helper'

RSpec.describe ProjectsController do
  specify do
    post '/projects'

    expect(response).to have_http_status(204)
  end

  def parsed_body
    JSON.parse(response.body)
  end
end
