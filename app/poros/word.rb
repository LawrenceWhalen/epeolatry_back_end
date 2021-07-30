class Word
  attr_reader :word,
              :definition,
              :phonetic,
              :phonetic_link,
              :part_of_speech,
              :synonyms,
              :example

  def initialize(info)
    @word = info[:word]
    @definition = info[:definition]
    @phonetic = info[:phonetic]
    @phonetic_link = info[:phonetic_link]
    @part_of_speech = info[:part_of_speech]
    @synonyms = info[:part_of_speech]
    @example = info[:example]
  end
end
