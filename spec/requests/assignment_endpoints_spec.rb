RSpec.describe 'Assignment requests', type: :request do
  specify 'empty list of assignments' do
    post '/assignments'

    expect(response).to have_http_status(204)
  end

  def parsed_body
    JSON.parse(response.body)
  end
end
