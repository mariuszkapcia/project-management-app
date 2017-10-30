require 'rails_helper'

RSpec.describe ProjectsController do
  specify do
    post '/projects', params: awesome_project
    expect(response).to have_http_status(201)
  end

  private

  def awesome_project
    {
      'uuid' => '64e60dee-15a4-4ce1-ac5f-dad76bb4e1a0',
      'name' => 'awesome_project'
    }
  end

  def parsed_body
    JSON.parse(response.body)
  end
end
