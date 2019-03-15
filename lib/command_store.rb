class CommandStore
  class Command < ActiveRecord::Base
    self.table_name = 'command_store_commands'
  end
  private_constant :Command

  def store(command)
    Command.create!(
      command_type: command.class.to_s,
      data:         serializer.dump(command.as_json)
    )

    :success
  end

  def read_all
    Command.all.map do |command|
      command_class      = command.command_type.constantize
      command_attributes = serializer.load(command.data).symbolize_keys
      command_class.new(command_attributes)
    end
  end

  def delete_all
    Command.destroy_all

    :success
  end

  private

  attr_reader :serializer

  def initialize(serializer: YAML)
    @serializer = serializer
  end
end
