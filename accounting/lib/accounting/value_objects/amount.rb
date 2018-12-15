module Accounting
  class Amount
    include Comparable

    def initialize(value, currency)
      @value    = value
      @currency = currency
    end

    def <=>(other)
      self.class == other.class && value == other.value && currency == other.currency ? 0 : -1
    end

    def negative?
      @value < 0
    end

    def to_f
      value
    end

    def to_s
      "#{sprintf('%.2f', value)} #{currency}"
    end

    def +(other)
      raise ArgumentError if currency != other.currency

      self.class.new(value + other.value, currency)
    end

    def -(other)
      raise ArgumentError if currency != other.currency

      self.class.new(value - other.value, currency)
    end

    def *(other_value)
      raise ArgumentError unless other_value.class.in?([Integer, Float])

      self.class.new(value * other_value, currency)
    end

    protected

    attr_reader :value, :currency
  end
end
