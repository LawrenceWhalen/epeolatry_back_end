class UserWordsFacade

  def self.create_word(input_word)
    word_response = WordService.search(input_word)

    if word_response.is_a? Array
      Word.create(word: word_response.first[:word],
                 definition: word_response.first[:meanings].first[:definitions].first[:definition],
                 phonetic: word_response.first[:phonetics].first[:text],
                 phonetic_link: word_response.first[:phonetics].first[:audio],
                 part_of_speech: word_response.first[:meanings].first[:partOfSpeech],
                 synonyms: word_response.first[:meanings].first[:definitions].first[:synonyms],
                 example: word_response.first[:meanings].first[:definitions].first[:example])
    elsif word_response.class == Hash
      word_response[:message] + " " + word_response[:resolution]
    end
  end
end
