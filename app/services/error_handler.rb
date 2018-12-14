class ErrorHandler
  def self.json_for(error_code)
    error_code = error_code.to_sym

    ERRORS
      .fetch(error_code)
      .merge(message: message_for(error_code))
  end

  GENERAL = {
    internal_server_error:          { code: '1000' },
    incorrect_uuid:                 { code: '1001' }
  }.freeze

  DEVELOPERS = {
    email_address_not_uniq:         { code: '2000' }
  }.freeze

  PROJECTS = {
  }.freeze

  ERRORS = GENERAL
    .merge(DEVELOPERS)
    .merge(PROJECTS)
    .freeze

  def self.message_for(error_code)
    I18n.t(error_code.to_sym, scope: :error_handler)
  end
end
