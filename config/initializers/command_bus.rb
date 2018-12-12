Rails.configuration.to_prepare do
  Rails.configuration.command_bus = Arkency::CommandBus.new
end
