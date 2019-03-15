RSpec.describe 'CommandStore' do
  specify 'should store a command' do
    command       = FakeCommand.new(attribute_1: attribute_1, attribute_2: attribute_2)
    command_store = CommandStore.new

    expect(
      command_store.store(command)
    ).to eq(:success)
  end

  specify 'should read all commands' do
    command       = FakeCommand.new(attribute_1: attribute_1, attribute_2: attribute_2)
    command_store = CommandStore.new

    command_store.store(command)
    commands = command_store.read_all

    expect(commands.size).to eq(1)
    expect(commands.first.class).to eq(FakeCommand)
    expect(commands.first.as_json).to eq(command.as_json)
  end

  specify 'should delete all commands' do
    command       = FakeCommand.new(attribute_1: attribute_1, attribute_2: attribute_2)
    command_store = CommandStore.new

    command_store.store(command)
    expect(
      command_store.delete_all
    ).to eq(:success)
    commands = command_store.read_all

    expect(commands.size).to eq(0)
  end

  private

  class FakeCommand
    include Command

    attr_accessor :attribute_1
    attr_accessor :attribute_2

    def initialize(attribute_1:, attribute_2:)
      @attribute_1 = attribute_1
      @attribute_2 = attribute_2
    end
  end

  def attribute_1
    'attribute_1'
  end

  def attribute_2
    'attribute_2'
  end
end
