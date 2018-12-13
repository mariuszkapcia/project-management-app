class AddDeadlineToUiProjectDetailsReadModel < ActiveRecord::Migration[5.1]
  def change
    add_column :ui_project_details_read_model, :deadline, :datetime
  end
end
