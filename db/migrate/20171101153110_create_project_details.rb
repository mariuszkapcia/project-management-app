class CreateProjectDetails < ActiveRecord::Migration[5.1]
  def up
    create_table :project_details, id: false do |t|
      t.uuid :uuid, primary_key: true, null: false
      t.string :name
      t.integer :estimation_in_hours
    end
  end

  def down
    drop_table :project_details
  end
end
