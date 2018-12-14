class CreateUiProjectAproximateEndReadModel < ActiveRecord::Migration[5.1]
  def up
    create_table :ui_project_aproximate_end_read_model, id: false do |t|
      t.uuid     :uuid, primary_key: true, null: false
      t.integer  :estimation
      t.datetime :deadline
      t.jsonb    :working_hours, default: []
      t.datetime :approximate_end
    end
  end

  def down
    drop_table :ui_project_aproximate_end_read_model
  end
end
