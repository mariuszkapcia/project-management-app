path = Rails.root.join('notifications/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
