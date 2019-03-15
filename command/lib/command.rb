require 'active_model'

module Command
  ValidationError = Class.new(StandardError)

  UUID_REGEXP  = /\A[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\Z/i
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def self.included(base)
    base.include ActiveModel::Model
    base.include ActiveModel::Validations
    base.include ActiveModel::Conversion
  end

  def verify!
    return if valid?
    first_error = errors.to_hash.first[1][0]
    raise ValidationError, first_error
  end

  def serialize
    as_json.except('validation_context', 'errors')
  end
end
