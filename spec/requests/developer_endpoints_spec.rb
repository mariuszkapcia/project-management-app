require_relative '../support/test_attributes'

RSpec.describe 'Developer requests', type: :request do
  include TestAttributes

  specify 'empty list of developers' do
    get '/developers'
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify 'register a new developer' do
    post '/developers', params: ignacy
    expect(response).to have_http_status(201)

    get '/developers'
    expected_response([ignacy])
  end

  private

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
