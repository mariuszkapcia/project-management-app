class ProjectsReadModel
  def handle(event)
    case event
      when Assignments::ProjectRegistered
        create_project(
          event.data[:uuid],
          event.data[:name]
        )
    end
  end

  def all
    ::Project.all
  end

  private

  def create_project(uuid, name)
    ::Project.create!(
      id: uuid,
      name: name
    )
  end
end
