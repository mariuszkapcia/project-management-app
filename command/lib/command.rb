require 'active_model'

module Command
  ValidationError = Class.new(StandardError)

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
end
