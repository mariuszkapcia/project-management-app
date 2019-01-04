require_dependency 'ui'

require_relative './support/test_attributes'

module UI
  RSpec.describe 'Notifications read model' do
    include TestAttributes

    specify 'generate notification for project kickoff' do
      read_model.call(project_kickoff_email_sent)
      expect(read_model.all.size).to eq(1)
      assert_notification_correct
    end

    private

    def assert_notification_correct
      expect(first_notification.message).to eq("Project #{project_topsecretdddproject[:name]} is ready to kickoff!")
    end

    def project_kickoff_email_sent
      Notifications::ProjectKickoffEmailSent.new(data: {
        project_uuid: project_topsecretdddproject[:uuid],
        project_name: project_topsecretdddproject[:name]
      })
    end

    def read_model
      @notification_list_read_model ||= UI::NotificationListReadModel.new
    end

    def first_notification
      read_model.all.first
    end
  end
end
