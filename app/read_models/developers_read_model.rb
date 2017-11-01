class DevelopersReadModel
  def handle(event)
    case event
      when Assignments::DeveloperRegistered
        create_developer(
          event.data[:uuid],
          event.data[:fullname],
          event.data[:email]
        )
    end
  end

  def all
    ::Developer.all
  end

  private

  def create_developer(uuid, fullname, email)
    ::Developer.create!(
      uuid:     uuid,
      fullname: fullname,
      email:    email
    )
  end
end
