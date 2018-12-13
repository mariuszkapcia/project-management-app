module UI
  class ProjectDetailsReadModel
    def call(event)
      case event
        when ProjectManagement::ProjectRegistered
          create_project(event.data[:uuid], event.data[:name])
        when ProjectManagement::ProjectEstimated
          estimate_project(event.data[:uuid], event.data[:hours])
        when ProjectManagement::DeadlineAssignedToProject
          assign_deadline(event.data[:uuid], event.data[:deadline])
        when ProjectManagement::DeveloperAssignedToProject
          assign_developer(event.data[:project_uuid], event.data[:developer_uuid], event.data[:developer_fullname])
        when ProjectManagement::DeveloperWorkingHoursForProjectAssigned
          assign_developer_working_hours(
            event.data[:project_uuid], event.data[:developer_uuid], event.data[:hours_per_week]
          )
      end
    end

    def all
      UI::ProjectDetails.all
    end

    def find(uuid)
      UI::ProjectDetails.find_by(uuid: uuid)
    end

    private

    def create_project(uuid, name)
      UI::ProjectDetails.create!(uuid: uuid, name: name)
    end

    def estimate_project(uuid, hours)
      project_details = UI::ProjectDetails.find_by(uuid: uuid)
      project_details.estimation_in_hours = hours
      project_details.save!
    end

    def assign_deadline(uuid, deadline)
      project_details = UI::ProjectDetails.find_by(uuid: uuid)
      project_details.deadline = deadline
      project_details.save!
    end

    def assign_developer(project_uuid, developer_uuid, developer_fullname)
      project_details = UI::ProjectDetails.find_by(uuid: project_uuid)
      project_details.developers << {
        uuid:           developer_uuid,
        fullname:       developer_fullname,
        hours_per_week: 0
      }
      project_details.save!
    end

    def assign_developer_working_hours(project_uuid, developer_uuid, hours_per_week)
      project_details             = UI::ProjectDetails.find_by(uuid: project_uuid)
      developer                   = find_developer(project_details.developers, developer_uuid)
      developer['hours_per_week'] = hours_per_week
      project_details.save!
    end

    def find_developer(developers, developer_uuid)
      developers.find { |developer| developer['uuid'] == developer_uuid }
    end
  end
end
