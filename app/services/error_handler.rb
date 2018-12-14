class ErrorHandler
  def self.json_for(error_code)
    error_code = error_code.to_sym

    ERRORS
      .fetch(error_code)
      .merge(message: message_for(error_code))
  end

  GENERAL = {
    internal_server_error:            { code: '1000' },
    incorrect_uuid:                   { code: '1001' }
  }.freeze

  DEVELOPERS = {
    email_address_not_uniq:           { code: '2000' },
    developer_fullname_missing:       { code: '2001' },
    developer_email_missing:          { code: '2002' }
  }.freeze

  PROJECTS = {
    deadline_from_past:               { code: '3000' },
    project_name_missing:             { code: '3001' },
    project_hours_missing:            { code: '3002' },
    project_deadline_missing:         { code: '3003' },
    developer_already_assigned:       { code: '3004' },
    hours_per_week_exceeded:          { code: '3005' },
    developer_hours_per_week_missing: { code: '3006' },
    invalid_estimation:               { code: '3007' },
    invalid_working_hours:            { code: '3008' }
  }.freeze

  ERRORS = GENERAL
    .merge(DEVELOPERS)
    .merge(PROJECTS)
    .freeze

  def self.message_for(error_code)
    I18n.t(error_code.to_sym, scope: :error_handler)
  end
end
