class CreateUiOrderListReadModel < ActiveRecord::Migration[5.1]
  def change
    create_table :ui_order_list_read_model, id: false do |t|
      t.uuid   :uuid, primary_key: true, null: false
      t.string :name
    end
  end
end
