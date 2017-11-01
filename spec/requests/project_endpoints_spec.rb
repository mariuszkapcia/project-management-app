RSpec.describe 'Projects requests', type: :request do
  specify 'empty list of projects' do
    get '/projects'
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify 'creates and list one project' do
    post '/projects', params: project
    expect(response).to have_http_status(201)
    get '/projects'
    expected_response([project])
  end

  specify 'estimate the project' do
    post '/projects', params: project
    expect(response).to have_http_status(201)
    put "/projects/#{project_uuid}/estimate", params: { hours: project_estimation }
    expect(response).to have_http_status(200)
    get '/projects'
    expected_response([project])
  end

  private

  def project
    {
      'uuid' => project_uuid,
      'name' => project_name
    }
  end

  def project_uuid
    '64e60dee-15a4-4ce1-ac5f-dad76bb4e1a0'
  end

  def project_name
    'awesome_project'
  end

  def project_estimation
    40
  end

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
