require_relative './support/test_attributes'

RSpec.describe 'Command sourcing', type: :request do
  include TestAttributes

  specify 'should replay the whole system from commands' do
    prepare_system
    original_system_dump = dump_system
    clear_system
    replay_system(original_system_dump.commands)
    replayed_system_dump = dump_system

    expect(serialize_events(original_system_dump.events)).to eq(serialize_events(replayed_system_dump.events))
    expect(serialize_commands(original_system_dump.commands)).to eq(serialize_commands(replayed_system_dump.commands))
  end

  private

  def prepare_system
    post '/developers',
      params: ignacy,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    post '/projects',
      params: project,
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(201)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_deadline",
      params: { deadline: project_topsecretdddproject[:deadline].to_i },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    put "/projects/#{project_topsecretdddproject[:uuid]}/estimate",
      params: { hours: project_topsecretdddproject[:estimation] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_developer",
      params: { developer_uuid: developer_ignacy[:uuid] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)

    put "/projects/#{project_topsecretdddproject[:uuid]}/assign_working_hours",
      params: { developer_uuid: developer_ignacy[:uuid], hours_per_week: developer_ignacy[:hours_per_week] },
      headers: { accept: 'application/json' }
    expect(response).to have_http_status(204)
  end

  def ignacy
    {
      'uuid'     => developer_ignacy[:uuid],
      'fullname' => developer_ignacy[:fullname],
      'email'    => developer_ignacy[:email]
    }
  end

  def project
    {
      'uuid' => project_topsecretdddproject[:uuid],
      'name' => project_topsecretdddproject[:name]
    }
  end

  def serialize_events(events)
    events.map { |event| { event_type: event.class.to_s, event_data: event.data } }
  end

  def serialize_commands(commands)
    commands.map { |command| { command_type: command.class.to_s, command_data: command.serialize } }
  end

  def dump_event_store
    event_store.read.each.to_a
  end

  def dump_command_store
    command_store.read_all
  end

  def dump_system
    OpenStruct.new(events: dump_event_store, commands: dump_command_store)
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

  def clear_system
    clear_event_store
    clear_command_store
    clear_read_models
  end

  def replay_system(commands)
    commands.each do |command|
      command_bus.call(command.dup)
    end
  end

  def event_store
    Rails.configuration.event_store
  end

  def command_store
    Rails.configuration.command_store
  end

  def command_bus
    Rails.configuration.command_bus
  end
end
