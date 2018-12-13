require_relative '../support/test_attributes'

RSpec.describe 'Project requests', type: :request do
  include TestAttributes

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

    put "/projects/#{project_topsecretdddproject[:uuid]}/estimate",
      params: { hours: project_topsecretdddproject[:estimation] }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}"
    expected_response(project_with_estimation)
  end

  specify 'assign developer to the project' do
    post '/developers', params: ignacy
    expect(response).to have_http_status(201)

    post '/projects', params: project
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_developer",
      params: { developer_uuid: developer_ignacy[:uuid] }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}"
    expected_response(project_with_developers)
  end

  specify 'assign working hours to the project' do
    post '/developers', params: ignacy
    expect(response).to have_http_status(201)

    post '/projects', params: project
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_developer",
      params: { developer_uuid: developer_ignacy[:uuid] }
    expect(response).to have_http_status(204)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_working_hours",
      params: { developer_uuid: developer_ignacy[:uuid], hours_per_week: developer_ignacy[:hours_per_week] }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}"
    expected_response(project_with_developers_and_hours)
  end

  private

  def project
    {
      'uuid' => project_topsecretdddproject[:uuid],
      'name' => project_topsecretdddproject[:name]
    }
  end

  def project_with_estimation
    {
      'uuid'                => project_topsecretdddproject[:uuid],
      'name'                => project_topsecretdddproject[:name],
      'estimation_in_hours' => project_topsecretdddproject[:estimation],
      'developers'          => []
    }
  end

  def project_with_developers
    {
      'uuid'                => project_topsecretdddproject[:uuid],
      'name'                => project_topsecretdddproject[:name],
      'estimation_in_hours' => nil,
      'developers'          => [
        {
          'uuid'           => developer_ignacy[:uuid],
          'fullname'       => developer_ignacy[:fullname],
          'hours_per_week' => 0
        }
      ]
    }
  end

  def project_with_developers_and_hours
    {
      'uuid'                => project_topsecretdddproject[:uuid],
      'name'                => project_topsecretdddproject[:name],
      'estimation_in_hours' => nil,
      'developers'          => [
        {
          'uuid'           => developer_ignacy[:uuid],
          'fullname'       => developer_ignacy[:fullname],
          'hours_per_week' => developer_ignacy[:hours_per_week]
        }
      ]
    }
  end

  def ignacy
    {
      'uuid'     => developer_ignacy[:uuid],
      'fullname' => developer_ignacy[:fullname],
      'email'    => developer_ignacy[:email]
    }
  end

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
