RSpec.describe 'Project requests', type: :request do
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
    get "/projects/#{project_uuid}"
    expected_response(project_with_estimation)
  end

  specify 'assign developer to the project' do
    post '/developers', params: ignacy
    expect(response).to have_http_status(201)

    post '/projects', params: project
    expect(response).to have_http_status(201)
    put "/projects/#{project_uuid}/assign_developer", params: { developer_uuid: ignacy_uuid }
    expect(response).to have_http_status(204)
    get "/projects/#{project_uuid}"
    expected_response(project_with_developers)
  end

  private

  def project
    {
      'uuid' => project_uuid,
      'name' => project_name
    }
  end

  def project_with_estimation
    {
      'uuid'                => project_uuid,
      'name'                => project_name,
      'estimation_in_hours' => project_estimation,
      'developers'          => []
    }
  end

  def project_with_developers
    {
      'uuid'                => project_uuid,
      'name'                => project_name,
      'estimation_in_hours' => nil,
      'developers'          => [{ 'uuid' => ignacy_uuid, 'fullname' => ignacy_fullname }]
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

  def ignacy
    {
      'uuid'     => ignacy_uuid,
      'fullname' => ignacy_fullname,
      'email'    => 'ignacy@onet.pl'
    }
  end

  def ignacy_uuid
    'c45d96d9-cdb0-4eec-9092-b3ea6c264648'
  end

  def ignacy_fullname
    'Ignacy Ignacy'
  end

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
