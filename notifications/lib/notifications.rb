module Notifications
end

require_dependency 'notifications/command_handlers/notifications_command_handler.rb'

require_dependency 'notifications/commands/send_project_kickoff_email.rb'

require_dependency 'notifications/domain_events/project_kickoff_email_sent.rb'
