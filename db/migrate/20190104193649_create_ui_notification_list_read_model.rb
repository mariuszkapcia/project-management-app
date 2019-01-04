class CreateUiNotificationListReadModel < ActiveRecord::Migration[5.1]
  def change
    create_table :ui_notification_list_read_model do |t|
      t.text :message
    end
  end
end
