class RenameProjectDetailsToUiProjectDetailsReadModel < ActiveRecord::Migration[5.1]
  def change
    rename_table :project_details, :ui_project_details_read_model
  end
end
