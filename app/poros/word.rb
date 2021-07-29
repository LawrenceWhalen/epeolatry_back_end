class Word
  attr_reader :definition, :phonetic, :part_of_speech, :synonyms, :example

  def initialize(info)
    @definition = info[:definition]
    @phonetic = info[:phonetic]
    @part_of_speech = info[:part_of_speech]
    @synonyms = info[:part_of_speech]
    @example = info[:example]
  end

end
