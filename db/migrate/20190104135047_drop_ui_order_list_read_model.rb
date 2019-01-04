class DropUiOrderListReadModel < ActiveRecord::Migration[5.1]
  def up
    drop_table :ui_order_list_read_model
  end

  def down
    create_table :ui_order_list_read_model, id: false do |t|
      t.uuid   :uuid, primary_key: true, null: false
      t.string :name
    end
  end
end
