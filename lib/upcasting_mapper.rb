class UpcastingMapper
  def call(event)
    case event
    when ProjectManagement::ProjectEstimated
      ProjectManagement::ProjectEstimatedV2.strict(data: {
        project_uuid: event.data[:project_uuid],
        hours:        event.data[:hours],
        story_points: 0
      })
    end
  end
end
