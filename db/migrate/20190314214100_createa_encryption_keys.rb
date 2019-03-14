class CreateaEncryptionKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :encryption_keys do |t|
      t.string :cipher
      t.binary :iv
      t.binary :key
      t.string :identifier
    end

    add_index :encryption_keys, [:identifier, :cipher], unique: true
  end
end
