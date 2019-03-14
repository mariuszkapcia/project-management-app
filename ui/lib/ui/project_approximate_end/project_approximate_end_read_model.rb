# TODO: Add missing spec.
module UI
  class ProjectApproximateEndReadModel
    def call(event)
      case event
        when ProjectManagement::ProjectRegistered
          add_project(event.data[:project_uuid])
        when ProjectManagement::ProjectEstimatedV2
          assign_estimation(event.data[:project_uuid], event.data[:hours])
          calculate_aproximate_end(event.data[:project_uuid])
        when ProjectManagement::DeveloperWorkingHoursForProjectAssigned
          assign_developer_working_hours(
            event.data[:project_uuid], event.data[:developer_uuid], event.data[:hours_per_week]
          )
          calculate_aproximate_end(event.data[:project_uuid])
      end
    end

    def for_project(project_uuid)
      UI::ProjectApproximateEnd::Project.find_by(uuid: project_uuid).try(:approximate_end)
    end

    private

    def add_project(project_uuid)
      UI::ProjectApproximateEnd::Project.create!(uuid: project_uuid)
    end

    def assign_estimation(project_uuid, estimation)
      project            = UI::ProjectApproximateEnd::Project.find_by(uuid: project_uuid)
      project.estimation = estimation
      project.save!
    end

    def assign_developer_working_hours(project_uuid, developer_uuid, hours_per_week)
      project                 = UI::ProjectApproximateEnd::Project.find_by(uuid: project_uuid)
      project.working_hours ||= {}
      project.working_hours[developer_uuid] = hours_per_week
      project.save!
    end

    def calculate_aproximate_end(project_uuid)
      project = UI::ProjectApproximateEnd::Project.find_by(uuid: project_uuid)
      return if project.estimation.nil? || project.working_hours.empty?

      week_length  = 7
      weekly_hours = project.working_hours.values.inject(0) do |hours_per_week, state|
        state + hours_per_week
      end
      number_of_weeks = (project.estimation / weekly_hours.to_f).round

      project.approximate_end = (number_of_weeks * week_length).days.from_now
      project.save!
    end
  end
end
