class ProjectsReadModel
  def handle(event)
    case event
      when ProjectManagement::ProjectRegistered
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
      uuid: uuid,
      name: name
    )
  end
end
