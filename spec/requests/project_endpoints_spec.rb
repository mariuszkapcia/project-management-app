RSpec.describe 'Projects controller', type: :request do
  specify do
    get '/projects'
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify do
    post '/projects', params: awesome_project
    expect(response).to have_http_status(201)
    get '/projects'
    expected_response([awesome_project])
  end

  private

  def awesome_project
    {
      'uuid' => awesome_project_uuid,
      'name' => awesome_project_name
    }
  end

  def awesome_project_uuid
    '64e60dee-15a4-4ce1-ac5f-dad76bb4e1a0'
  end

  def awesome_project_name
    'awesome_project'
  end

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
