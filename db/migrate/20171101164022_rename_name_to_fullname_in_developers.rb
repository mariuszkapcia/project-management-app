class RenameNameToFullnameInDevelopers < ActiveRecord::Migration[5.1]
  def up
    rename_column :developers, :name, :fullname
  end

  def down
    rename_column :developers, :fullname, :name
  end
end
