RSpec.describe 'Developers read model' do
  specify 'creates developer' do
    developers_read_model.call(developer_registered)
    expect(developers_read_model.all.size).to eq(1)
    assert_developer_correct
  end

  private

  def assert_developer_correct
    expect(first_developer.uuid).to eq(developer_uuid)
    expect(first_developer.fullname).to eq(developer_fullname)
  end

  def developer_registered
    ProjectManagement::DeveloperRegistered.new(data: {
      uuid:     developer_uuid,
      fullname: developer_fullname
    })
  end

  def developer_uuid
    'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
  end

  def developer_fullname
    'Ignacy Ignacy'
  end

  def developers_read_model
    @developers_read_model ||= DevelopersReadModel.new
  end

  def first_developer
    developers_read_model.all.first
  end
end
