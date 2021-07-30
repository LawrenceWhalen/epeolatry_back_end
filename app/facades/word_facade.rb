class WordFacade
  def self.word_search(searched_word)
    result = WordService.search(searched_word)
    Word.new(word: result.first[:word],
             definition: result.first[:meanings].first[:definitions].first[:definition],
             phonetic: result.first[:phonetics].first[:text],
             phonetic_link: result.first[:phonetics].first[:audio],
             part_of_speech: result.first[:meanings].first[:partOfSpeech],
             synonyms: result.first[:meanings].first[:definitions].first[:synonym],
             example: result.first[:meanings].first[:definitions].first[:example])
  end
end
