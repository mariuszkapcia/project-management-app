path = Rails.root.join('project_management/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
