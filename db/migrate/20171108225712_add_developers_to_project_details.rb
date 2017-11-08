class AddDevelopersToProjectDetails < ActiveRecord::Migration[5.1]
  def up
    add_column :project_details, :developers, :jsonb, default: []
  end

  def down
    remove_column :project_details, :developers
  end
end
