class RenameProjectsToUiProjectListReadModel < ActiveRecord::Migration[5.1]
  def change
    rename_table :projects, :ui_project_list_read_model
  end
end
