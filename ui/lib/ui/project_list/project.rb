module UI
  module ProjectList
    class Project < ActiveRecord::Base
      self.table_name = 'ui_project_list_read_model'
    end
  end
end
