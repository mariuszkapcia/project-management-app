path = Rails.root.join('assignments/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
