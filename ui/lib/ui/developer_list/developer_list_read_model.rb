module UI
  class DeveloperListReadModel
    def call(event)
      case event
        when ProjectManagement::DeveloperRegistered
          create_developer(event.data[:developer_uuid], event.data[:fullname], event.data[:email])
        when ProjectManagement::DeveloperRemoved
          remove_developer(event.data[:developer_uuid])
      end
    end

    def all
      UI::DeveloperList::Developer.all
    end

    def find(uuid)
      UI::DeveloperList::Developer.find(uuid)
    end

    private

    def create_developer(developer_uuid, fullname, email)
      UI::DeveloperList::Developer.create!(uuid: developer_uuid, fullname: fullname, email: email)
    end

    def remove_developer(developer_uuid)
      UI::DeveloperList::Developer.where(uuid: developer_uuid).destroy_all
    end
  end
end
