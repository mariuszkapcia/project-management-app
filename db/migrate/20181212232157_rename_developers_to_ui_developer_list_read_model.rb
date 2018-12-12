class RenameDevelopersToUiDeveloperListReadModel < ActiveRecord::Migration[5.1]
  def change
    rename_table :developers, :ui_developer_list_read_model
  end
end
