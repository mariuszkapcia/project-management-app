RSpec.describe 'Developer requests', type: :request do
  specify 'empty list of developers' do
    get '/developers'
    expect(response).to have_http_status(200)
    expected_response([])
  end

  specify 'register a new developer' do
    post '/developers', params: ignacy
    expect(response).to have_http_status(201)
  end

  private

  def ignacy
    {
      uuid: '99912b93-ba22-48da-ac83-f49a74db22e4',
      name: 'Ignacy'
    }
  end

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
