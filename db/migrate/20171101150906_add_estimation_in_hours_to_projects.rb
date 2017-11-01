class AddEstimationInHoursToProjects < ActiveRecord::Migration[5.1]
  def up
    add_column :projects, :estimation_in_hours, :integer
  end

  def down
    remove_column :projects, :estimation_in_hours
  end
end
