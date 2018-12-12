RSpec.describe 'Project details read model' do
  specify 'creates project' do
    project_details_read_model.call(project_registered)
    expect(project_details_read_model.all.size).to eq(1)
    assert_project_correct
  end

  specify 'estimate the project' do
    project_details_read_model.call(project_registered)
    project_details_read_model.call(project_estimated)
    expect(project_details_read_model.all.size).to eq(1)
    assert_project_with_estimation_correct
  end

  specify 'assign developer to the project' do
    project_details_read_model.call(project_registered)
    project_details_read_model.call(developer_assigned)
    expect(project_details_read_model.all.size).to eq(1)
    assert_project_with_developers_correct
  end

  private

  def assert_project_correct
    expect(first_project.uuid).to eq(project_uuid)
    expect(first_project.name).to eq(project_name)
    expect(first_project.estimation_in_hours).to eq(nil)
    expect(first_project.developers).to eq([])
  end

  def assert_project_with_estimation_correct
    expect(first_project.uuid).to eq(project_uuid)
    expect(first_project.name).to eq(project_name)
    expect(first_project.estimation_in_hours).to eq(project_estimation)
    expect(first_project.developers).to eq([])
  end

  def assert_project_with_developers_correct
    expect(first_project.uuid).to eq(project_uuid)
    expect(first_project.name).to eq(project_name)
    expect(first_project.estimation_in_hours).to eq(nil)
    expect(first_project.developers).to eq([{ 'uuid' => ignacy_uuid, 'fullname' => ignacy_fullname }])
  end

  def project_registered
    ProjectManagement::ProjectRegistered.new(data: {
      uuid: project_uuid,
      name: project_name
    })
  end

  def project_estimated
    ProjectManagement::ProjectEstimated.new(data: {
      uuid:  project_uuid,
      hours: project_estimation
    })
  end

  def developer_assigned
    ProjectManagement::DeveloperAssignedToProject.new(data: {
      project_uuid:       project_uuid,
      developer_uuid:     ignacy_uuid,
      developer_fullname: ignacy_fullname
    })
  end

  def project_uuid
    'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
  end

  def project_name
    'awesome_project'
  end

  def project_estimation
    40
  end

  def ignacy_uuid
    '4b449030-a3c9-4568-9c40-0e8660d7c63b'
  end

  def ignacy_fullname
    'Ignacy Ignacy'
  end

  def project_details_read_model
    @project_details_read_model ||= ProjectDetailsReadModel.new
  end

  def first_project
    project_details_read_model.all.first
  end
end
