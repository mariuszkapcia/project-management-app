path = Rails.root.join('ui/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
