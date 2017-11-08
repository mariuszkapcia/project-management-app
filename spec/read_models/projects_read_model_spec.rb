RSpec.describe 'Projects read model' do
  specify 'creates project' do
    projects_read_model.handle(project_registered)
    expect(projects_read_model.all.size).to eq(1)
    assert_project_correct
  end

  private

  def assert_project_correct
    expect(first_project.uuid).to eq(project_uuid)
    expect(first_project.name).to eq(project_name)
  end

  def project_registered
    ProjectManagement::ProjectRegistered.new(data: {
      uuid: project_uuid,
      name: project_name
    })
  end

  def project_uuid
    'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
  end

  def project_name
    'awesome_project'
  end

  def projects_read_model
    @projects_read_model ||= ProjectsReadModel.new
  end

  def first_project
    projects_read_model.all.first
  end
end
