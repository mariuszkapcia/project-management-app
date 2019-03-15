namespace :command_sourcing do
  desc 'Replay the whole system from commands'
  task replay: :environment do
    ActiveRecord::Base.transaction do
      commands = dump_command_store
      clear_system
      replay_system(commands)
    end
  end

  def replay_system(commands)
    commands.each do |command|
      command_bus.call(command.dup)
    end
  end

  def dump_command_store
    command_store.read_all
  end

  def clear_system
    clear_event_store
    clear_command_store
    clear_read_models
  end

  def clear_event_store
    RailsEventStoreActiveRecord::Event.destroy_all
    RailsEventStoreActiveRecord::EventInStream.destroy_all
  end

  def clear_command_store
    command_store.delete_all
  end

  def clear_read_models
    UI::DeveloperListReadModel.new.delete_all
    UI::NotificationListReadModel.new.delete_all
    UI::ProjectApproximateEndReadModel.new.delete_all
    UI::ProjectDetailsReadModel.new.delete_all
    UI::ProjectListReadModel.new.delete_all
  end

  def command_store
    Rails.configuration.command_store
  end

  def command_bus
    Rails.configuration.command_bus
  end
end
