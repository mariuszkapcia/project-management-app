module Accounting
  class Amount
    include Comparable

    def initialize(cents, currency)
      @cents    = cents
      @currency = currency
    end

    def <=>(other)
      self.class == other.class && cents == other.cents && currency == other.currency ? 0 : -1
    end

    def negative?
      @cents < 0
    end

    def to_f
      (cents / 100.to_f)
    end

    def to_s
      "#{sprintf('%.2f', (cents / 100.to_f))} #{currency}"
    end

    def +(other)
      raise ArgumentError if currency != other.currency

      self.class.new(cents + other.cents, currency)
    end

    def -(other)
      raise ArgumentError if currency != other.currency

      self.class.new(cents - other.cents, currency)
    end

    def *(other_value)
      raise ArgumentError unless other_value.class.in?([Integer, Float])

      self.class.new(cents * other_value, currency)
    end

    protected

    attr_reader :cents, :currency
  end
end
