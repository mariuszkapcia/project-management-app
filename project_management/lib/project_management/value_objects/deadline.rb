module ProjectManagement
  class Deadline
    include Comparable

    InvalidValue = Class.new(StandardError)

    attr_reader :value

    def initialize(value)
      raise InvalidValue unless value.class.in?([Integer])
      Time.at(value) rescue TypeError raise InvalidValue

      @value = value
    end

    def <=>(other)
      self.class == other.class && value == other.value ? 0 : -1
    end

    def <(other)
      self.class == other.class && value < other.value
    end

    def to_datetime
      Time.at(value).utc.to_datetime#.strftime('%FT%T%:z')
    end
  end
end
