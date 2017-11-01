class AddEmailToDevelopers < ActiveRecord::Migration[5.1]
  def up
    add_column :developers, :email, :string
    add_index :developers, :email, unique: true
  end

  def down
    remove_column :developers, :email
  end
end
