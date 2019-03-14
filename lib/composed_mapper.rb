class ComposedMapper
  def initialize(*mappers)
    @serialization   = mappers.map { |mapper| mapper.method(:event_to_serialized_record) }
    @deserialization = mappers.reverse.map { |mapper| mapper.method(:serialized_record_to_event) }
  end

  def event_to_serialized_record(event)
    temp_event = event
    @serialization.each { |mapper| temp_event = mapper.call(temp_event) }
    temp_event
  end

  def serialized_record_to_event(record)
    temp_record = record
    @deserialization.each { |mapper| temp_record = mapper.call(temp_record) }
    temp_record
  end
end
