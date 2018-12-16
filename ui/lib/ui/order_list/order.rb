module UI
  module OrderList
    class Order < ActiveRecord::Base
      self.table_name = 'ui_order_list_read_model'
    end
  end
end
