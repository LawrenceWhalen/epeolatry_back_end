class BookAndWordSerializer

  def self.word_and_book_attributes(word, books)
    {
      wordData:
        { "id": word.id,
          "type": 'word',
          "attributes":
          {
          "word": word.word,
          "definition": word.definition,
          "part_of_speech": word.part_of_speech,
          "synonyms": word.synonyms,
          "phonetic": word.phonetic,
          "phonetic_link": word.phonetic_link
          }
        },

      booksData: books.map do |book|
        {
          "id": book.g_id,
          "type": 'book'
          "attributes":
          {
            "title": book.title,
            "author": book.author
          }
        }
      end
  end
end
