path = Rails.root.join('accounting/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
