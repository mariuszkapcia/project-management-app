module Accounting
  class ValuateOrder
    include Command

    attr_accessor :order_uuid
    attr_accessor :amount
    attr_accessor :currency

    validates :order_uuid, presence: { message: 'order_uuid_missing' },
                           format:   { with: UUID_REGEXP,
                                       message: 'incorrect_uuid' }
    validates :amount,     presence: { message: 'order_amount_missing' }
    validates :currency,   presence: { message: 'order_currency_missing' }

    def initialize(order_uuid:, amount:, currency:)
      @order_uuid = order_uuid
      @amount     = amount
      @currency   = currency
    end
  end
end
