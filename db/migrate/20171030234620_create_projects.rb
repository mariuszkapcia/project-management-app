class CreateProjects < ActiveRecord::Migration[5.1]
  def up
    create_table :projects, id: false do |t|
      t.uuid :uuid, primary_key: true, null: false
      t.string :name
    end
  end

  def down
    drop_table :projects
  end
end
