require_relative '../support/test_attributes'

RSpec.describe 'Project requests', type: :request do
  include TestAttributes

  specify 'empty list of notifications' do
    get '/notifications',
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify 'project kickoff notification' do
    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/estimate",
      params: { hours: project_topsecretdddproject[:estimation] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_deadline",
      params: { deadline: project_topsecretdddproject[:deadline].to_i },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    get '/notifications',
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(200)
    expected_response([project_kickoff_notification])
  end

  private

  def project
    {
      'uuid' => project_topsecretdddproject[:uuid],
      'name' => project_topsecretdddproject[:name]
    }
  end

  def project_kickoff_notification
    {
      'message' => "#{project_topsecretdddproject[:name]} is ready to kickoff!"
    }
  end

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
