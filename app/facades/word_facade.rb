class WordFacade
#make a helper method to dig into dataset
  def self.word_search(searched_word)
    result = WordService.search(searched_word)

    Word.new(definition: result.first[:meanings].first[:definitions].first[:definition],
             phonetic: result.first[:phonetics].first[:text],
             part_of_speech: result.first[:meanings].first[:partOfSpeech],
             synonyms: result.first[:meanings].first[:definitions].first[:synonym],
             example: result.first[:meanings].first[:definitions].first[:example])
  end
end
