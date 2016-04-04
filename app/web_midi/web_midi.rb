class WebMidi
  Navigator = Native(`navigator`)

  def initialize(options = {})
    success = lambda do |access|
      yield MidiAccess.new(access)
    end

    failure = lambda do |e|
      fail e
    end

    Navigator
      .requestMIDIAccess(options)
      .then(success, failure)
  end
end
