class MidiAccess
  def initialize(access)
    @access = Native(access)
  end

  def inputs
    values_from_iterator(@access.inputs)
  end

  def outputs
    values_from_iterator(@access.outputs)
  end

  def values_from_iterator(iterator)
    values = iterator.values
    iterator.size.times.inject([]) do |out, _i|
      out << values.next.value
    end
  end
end
