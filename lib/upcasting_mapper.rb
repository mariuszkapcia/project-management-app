class UpcastingMapper
  def event_to_serialized_record(event)
    event
  end

  def serialized_record_to_event(record)
    case record
    when ProjectManagement::ProjectEstimated
      ProjectManagement::ProjectEstimatedV2.strict(data: {
        project_uuid: record.data[:project_uuid],
        hours:        record.data[:hours],
        story_points: 0
      })
    else record
    end
  end
end
