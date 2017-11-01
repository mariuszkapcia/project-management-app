class CreateDevelopers < ActiveRecord::Migration[5.1]
  def up
    create_table :developers, id: false do |t|
      t.uuid :uuid, primary_key: true, null: false
      t.string :name
    end
  end

  def down
    drop_table :developers
  end
end
