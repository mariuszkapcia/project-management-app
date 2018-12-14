module UI
  class ProjectApproximateEndReadModel
    def call(event)
      case event
        when ProjectManagement::ProjectEstimated
          assign_estimation(event.data[:uuid], event.data[:hours])
          calculate_aproximate_end
        when ProjectManagement::DeadlineAssignedToProject
          assign_deadline(event.data[:uuid], event.data[:deadline])
          calculate_aproximate_end
        when ProjectManagement::DeveloperWorkingHoursForProjectAssigned
          assign_developer_working_hours(
            event.data[:project_uuid], event.data[:developer_uuid], event.data[:hours_per_week]
          )
          calculate_aproximate_end
      end
    end

    def for_project(project_uuid)
      UI::ProjectApproximateEnd::Project.find_by(uuid: project_uuid).try(:approximate_end)
    end

    private

    def assign_estimation(project_uuid, estimation)
      project            = UI::ProjectApproximateEnd::Project.where(uuid: project_uuid).first_or_create!
      project.estimation = estimation
      project.save!
    end

    def assign_deadline(project_uuid, deadline)
      project          = UI::ProjectApproximateEnd::Project.where(uuid: project_uuid).first_or_create!
      project.deadline = deadline
      project.save!
    end

    def assign_developer_working_hours(project_uuid, developer_uuid, hours_per_week)
      project                 = UI::ProjectApproximateEnd::Project.where(uuid: project_uuid).first_or_create!
      project.working_hours ||= {}
      project.working_hours[developer_uuid] = hours_per_week
      project.save!
    end

    def calculate_aproximate_end
    end
  end
end
