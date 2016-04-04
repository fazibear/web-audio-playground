class MidiMessage
  def initialize(on)
    on.onmidimessage = lambda do |e|
      yield Native(e).data.to_a
    end
  end
end
