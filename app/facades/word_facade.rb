class WordFacade
#make a helper method to dig into dataset
  def self.define(searched_word)
    result = WordService.search(searched_word)

    definitions = result.first[:meanings].map do |meaning|
      meaning[:definitions].map do |definition|
        definition[:definition]
      end
    end.flatten
    Word.new(definition: definitions)
  end

  def self.phonetic(searched_word)
    result = WordService.search(searched_word)

    Word.new(phonetic: result.first[:phonetics].first[:text])
  end
end



# result.first[:meanings].first[:definitions].first[:definition]
