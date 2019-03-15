module UI
  class DeveloperListReadModel
    def call(event)
      case event
        when ProjectManagement::DeveloperRegistered
          create_developer(event.data[:developer_uuid], event.data[:fullname], event.data[:email])
      end
    end

    def all
      UI::DeveloperList::Developer.all
    end

    def find(uuid)
      UI::DeveloperList::Developer.find(uuid)
    end

    def delete_all
      UI::DeveloperList::Developer.destroy_all
    end

    private

    def create_developer(developer_uuid, fullname, email)
      UI::DeveloperList::Developer.create!(uuid: developer_uuid, fullname: fullname, email: email)
    end
  end
end
