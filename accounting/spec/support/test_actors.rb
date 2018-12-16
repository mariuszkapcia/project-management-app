require_relative './actors/test_order'

module Accounting
  module TestActors
    def instance_of_order(**kwargs)
      TestOrder.new(kwargs)
    end
  end
end
