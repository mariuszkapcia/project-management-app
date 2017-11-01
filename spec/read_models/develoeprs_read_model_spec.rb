RSpec.describe 'Developers read model' do
  specify 'creates developer' do
    developers_read_model.handle(developer_registered)
    expect(developers_read_model.all.size).to eq(1)
    assert_developer_correct
  end

  private

  def assert_developer_correct
    expect(first_developer.uuid).to eq(developer_uuid)
    expect(first_developer.name).to eq(developer_name)
  end

  def developer_registered
    Assignments::DeveloperRegistered.new(data: {
      uuid: developer_uuid,
      name: developer_name
    })
  end

  def developer_uuid
    'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
  end

  def developer_name
    'Ignacy'
  end

  def developers_read_model
    @developers_read_model ||= DevelopersReadModel.new
  end

  def first_developer
    developers_read_model.all.first
  end
end
