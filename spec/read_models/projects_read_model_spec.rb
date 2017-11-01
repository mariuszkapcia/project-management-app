RSpec.describe 'Projects read model' do
  specify 'creates project' do
    projects_read_model.handle(project_registered)
    expect(projects_read_model.all.size).to eq(1)
    assert_project_correct
  end

  specify 'estimate the project' do
    projects_read_model.handle(project_registered)
    projects_read_model.handle(project_estimated)
    expect(projects_read_model.all.size).to eq(1)
    assert_project_with_estimation_correct
  end

  private

  def assert_project_correct
    expect(first_project.uuid).to eq(project_uuid)
    expect(first_project.name).to eq(project_name)
    expect(first_project.estimation_in_hours).to eq(nil)
  end

  def assert_project_with_estimation_correct
    expect(first_project.uuid).to eq(project_uuid)
    expect(first_project.name).to eq(project_name)
    expect(first_project.estimation_in_hours).to eq(project_estimation)
  end

  def project_registered
    Assignments::ProjectRegistered.new(data: {
      uuid: project_uuid,
      name: project_name
    })
  end

  def project_estimated
    Assignments::ProjectEstimated.new(data: {
      uuid:  project_uuid,
      hours: project_estimation
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

  def projects_read_model
    @projects_read_model ||= ProjectsReadModel.new
  end

  def first_project
    projects_read_model.all.first
  end
end
