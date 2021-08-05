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

  def self.words_with_books(word_ids, user_id)
    glossary_objects = Glossary.find_books(word_ids, user_id)

    return 'No Words Saved' if glossary_objects == []

    word_with_book_objects = glossary_objects.map do |object|
      [Word.find(object.first.word_id),
      object.map do |word|
        BookFacade.create_book_object_with_given_id(word.book_id)
      end]
    end

    word_with_book_objects.map do |word|
      WordAndBooksPoro.new(
        word: word[0][:word],
        definition: word[0][:definition],
        phonetic: word[0][:phonetic],
        phonetic_link: word[0][:phonetic_link],
        part_of_speech: word[0][:part_of_speech],
        synonyms: word[0][:synonyms],
        example: word[0][:example],
        books: word[1].map do |book|
          [book.title, book.g_id]
        end
      )
    end
  end
end
