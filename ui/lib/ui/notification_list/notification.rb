module UI
  module NotificationList
    class Notification < ActiveRecord::Base
      self.table_name = 'ui_notification_list_read_model'
    end
  end
end
