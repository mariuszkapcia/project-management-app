class ProjectDetailsReadModel
  def call(event)
    case event
      when ProjectManagement::ProjectRegistered
        create_project(
          event.data[:uuid],
          event.data[:name]
        )
      when ProjectManagement::ProjectEstimated
        estimate_project(
          event.data[:uuid],
          event.data[:hours]
        )
      when ProjectManagement::DeveloperAssignedToProject
        assign_developer(
          event.data[:project_uuid],
          event.data[:developer_uuid],
          event.data[:developer_fullname]
        )
    end
  end

  def all
    ::ProjectDetails.all
  end

  def find(uuid)
    ::ProjectDetails.find_by(uuid: uuid)
  end

  private

  def create_project(uuid, name)
    ::ProjectDetails.create!(
      uuid: uuid,
      name: name
    )
  end

  def estimate_project(uuid, hours)
    ::ProjectDetails.find_by(uuid: uuid).update(
      estimation_in_hours: hours
    )
  end

  def assign_developer(project_uuid, developer_uuid, developer_fullname)
    project_details = ::ProjectDetails.find_by(uuid: project_uuid)
    project_details.developers << {
      uuid:     developer_uuid,
      fullname: developer_fullname
    }
    project_details.save!
  end
end
