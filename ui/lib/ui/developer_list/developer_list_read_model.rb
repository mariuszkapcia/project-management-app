module UI
  class DeveloperListReadModel
    def call(event)
      case event
        when ProjectManagement::DeveloperRegistered
          create_developer(event.data[:uuid], event.data[:fullname], event.data[:email])
      end
    end

    def all
      UI::Developer.all
    end

    def find(uuid)
      UI::Developer.find(uuid)
    end

    private

    def create_developer(uuid, fullname, email)
      UI::Developer.create!(uuid: uuid, fullname: fullname, email: email)
    end
  end
end