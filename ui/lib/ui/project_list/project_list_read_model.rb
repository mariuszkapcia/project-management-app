module UI
  class ProjectListReadModel
    def call(event)
      case event
        when ProjectManagement::ProjectRegistered
          create_project(event.data[:uuid], event.data[:name])
      end
    end

    def all
      UI::Project.all
    end

    private

    def create_project(uuid, name)
      UI::Project.create!(uuid: uuid, name: name)
    end
  end
end
