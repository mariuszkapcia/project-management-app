RSpec.describe 'Developer requests', type: :request do
  specify 'empty list of developers' do
    get '/developers'
    expect(response).to have_http_status(200)
    expected_response([])
  end

  private

  def expected_response(expected)
    expect(JSON.parse(response.body)).to match(expected)
  end
end
