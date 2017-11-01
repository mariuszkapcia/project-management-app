class ProjectsReadModel
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

  def all
    ::Project.all
  end

  private

  def create_project(uuid, name)
    ::Project.create!(
      uuid: uuid,
      name: name
    )
  end

  def estimate_project(uuid, hours)
    ::Project.find_by(uuid: uuid).update(
      estimation_in_hours: hours
    )
  end
end
