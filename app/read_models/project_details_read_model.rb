class ProjectDetailsReadModel
  def handle(event)
    case event
      when Assignments::ProjectRegistered
        create_project(
          event.data[:uuid],
          event.data[:name]
        )
      when Assignments::ProjectEstimated
        estimate_project(
          event.data[:uuid],
          event.data[:hours]
        )
    end
  end

  def find(uuid)
    ::ProjectDetails.find_by(uuid: uuid)
  end

  private

  def create_project(uuid, name)
    ::ProjectDetails.create!(
      uuid: uuid,
      name: name
    )
  end

  def estimate_project(uuid, hours)
    ::ProjectDetails.find_by(uuid: uuid).update(
      estimation_in_hours: hours
    )
  end
end
