class RemoveEstimationInHoursFromProjects < ActiveRecord::Migration[5.1]
  def up
    remove_column :projects, :estimation_in_hours, :integer
  end

  def down
    add_column :projects, :estimation_in_hours, :integer
  end
end
