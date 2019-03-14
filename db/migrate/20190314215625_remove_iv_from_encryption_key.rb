class RemoveIvFromEncryptionKey < ActiveRecord::Migration[5.1]
  def change
    remove_column :encryption_keys, :iv, :binary
  end
end
