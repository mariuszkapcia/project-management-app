require_relative '../support/test_attributes'

RSpec.describe 'Project requests', type: :request do
  include TestAttributes

  specify 'empty list of projects' do
    get '/projects',
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify 'creates and list one project' do
    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    get '/projects',
      headers: { accept: 'application/json' }
    expected_response([project])
  end

  specify 'estimate the project' do
    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/estimate",
      params: { hours: project_topsecretdddproject[:estimation] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}",
      headers: { accept: 'application/json' }
    expected_response(project_with_estimation)
  end

  specify 'assign developer to the project' do
    post '/developers',
      params: ignacy,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_developer",
      params: { developer_uuid: developer_ignacy[:uuid] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}",
      headers: { accept: 'application/json' }
    expected_response(project_with_developers)
  end

  specify 'assign working hours to the project' do
    post '/developers',
      params: ignacy,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_developer",
      params: { developer_uuid: developer_ignacy[:uuid] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_working_hours",
      params: { developer_uuid: developer_ignacy[:uuid], hours_per_week: developer_ignacy[:hours_per_week] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}",
      headers: { accept: 'application/json' }
    expected_response(project_with_developers_and_hours)
  end

  specify 'assign deadline to project' do
    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_deadline",
      params: { deadline: project_topsecretdddproject[:deadline].to_i },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    get "/projects/#{project_topsecretdddproject[:uuid]}",
      headers: { accept: 'application/json' }
    expected_response(project_with_deadline)
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
      'deadline'            => nil,
      'developers'          => []
    }
  end

  # TODO: Handle deadline in a better way.
  def project_with_deadline
    {
      'uuid'                => project_topsecretdddproject[:uuid],
      'name'                => project_topsecretdddproject[:name],
      'estimation_in_hours' => nil,
      'deadline'            => project_topsecretdddproject[:deadline].strftime('%FT%T.000Z'),
      'developers'          => []
    }
  end

  def project_with_developers
    {
      'uuid'                => project_topsecretdddproject[:uuid],
      'name'                => project_topsecretdddproject[:name],
      'estimation_in_hours' => nil,
      'deadline'            => nil,
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
      'deadline'            => nil,
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
