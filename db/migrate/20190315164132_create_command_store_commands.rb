class CreateCommandStoreCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :command_store_commands do |t|
      t.string   :command_type, null: false
      t.text     :data,         null: false
      t.datetime :created_at,   null: false
    end

    add_index :command_store_commands, :created_at
  end
end
