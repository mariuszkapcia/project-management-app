RSpec.describe 'Upcasting mapper' do
  specify 'converts_v1_to_v2' do
    project_estimated = ProjectManagement::ProjectEstimated.strict(data: {
      project_uuid: project_uuid,
      hours:        hours
    })
    project_estimated_v2 = UpcastingMapper.new.serialized_record_to_event(project_estimated)

    expect(project_estimated_v2.class).to eq(ProjectManagement::ProjectEstimatedV2)
    expect(project_estimated.data[:project_uuid]).to eq(project_estimated_v2.data[:project_uuid])
    expect(project_estimated.data[:hours]).to eq(project_estimated_v2.data[:hours])
    expect(project_estimated_v2.data[:story_points]).to eq(0)
  end

  private

  def project_uuid
    '29991ce3-6a7d-46e7-8ff9-16a1f3ece2dd'
  end

  def hours
    10
  end
end
