require 'sidekiq/testing'

require_relative '../support/test_attributes'

RSpec.describe 'Order requests', type: :request do
  include TestAttributes

  specify 'empty list of orders' do
    get '/orders',
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify 'register a new order' do
    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    get '/orders',
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(200)
    # NOTE: Order UUID is generated on the server and I'm not able to compare response.
    expect(parsed_body.size).to eq(1)
  end

  private

  def project
    {
      'uuid' => project_topsecretdddproject[:uuid],
      'name' => project_topsecretdddproject[:name]
    }
  end

  def expected_response(expected)
    expect(parsed_body).to match(expected)
  end

  def parsed_body
    JSON.parse(response.body)
  end
end
