class DevelopersReadModel
  def handle(event)
    case event
      when Assignments::DeveloperRegistered
        create_developer(
          event.data[:uuid],
          event.data[:name]
        )
    end
  end

  def all
    ::Developer.all
  end

  private

  def create_developer(uuid, name)
    ::Developer.create!(
      uuid: uuid,
      name: name
    )
  end
end
