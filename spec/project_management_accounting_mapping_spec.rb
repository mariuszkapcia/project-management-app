path = Rails.root.join('project_management_accounting_mapping/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
