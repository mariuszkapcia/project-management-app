module Notifications
end

require_dependency 'notifications/domain_events/project_kickoff_email_sent.rb'

require_dependency 'notifications/domain_services/project_kickoff_mailer.rb'

require_dependency 'notifications/handlers/project_kicked_off_handler.rb'
