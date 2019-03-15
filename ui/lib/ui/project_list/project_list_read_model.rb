module UI
  class ProjectListReadModel
    def call(event)
      case event
        when ProjectManagement::ProjectRegistered
          create_project(event.data[:project_uuid], event.data[:name])
      end
    end

    def all
      UI::ProjectList::Project.all
    end

    def delete_all
      UI::ProjectList::Project.destroy_all
    end

    private

    def create_project(project_uuid, name)
      UI::ProjectList::Project.create!(uuid: project_uuid, name: name)
    end
  end
end
