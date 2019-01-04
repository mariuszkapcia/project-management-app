module UI
  class NotificationListReadModel
    def call(event)
      case event
        when Notifications::ProjectKickoffEmailSent
          generate_project_kickoff_notification(event.data[:project_name])
      end
    end

    def all
      UI::NotificationList::Notification.all
    end

    private

    def generate_project_kickoff_notification(project_name)
      UI::NotificationList::Notification.create!(
        message: "#{project_name} is ready to kickoff!"
      )
    end
  end
end
