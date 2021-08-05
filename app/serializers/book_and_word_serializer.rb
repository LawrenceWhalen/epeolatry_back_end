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
          "type": 'book',
          "attributes":
          {
            "title": book.title,
            "author": book.author
          }
        }
      end
    }
  end

  def self.book_show_page_with_word_ids(book, words)
    { bookData:
      {
        id: book.g_id,
        type: 'book',
        attributes:
        {
          title: book.title,
          authors: book.authors,
          genres: book.genres,
          description: book.description,
          shelf: book.shelves
        }
      },
      wordData: words.map do |word|
      {
        id: word.id,
        type: 'word',
          attributes:
          {
            word: word.word
          }
      }
    end
    }
  end

  def self.book_show_page_with_no_word_ids(book)
    { bookData:
      {
        id: book.g_id,
        type: 'book',
        attributes:
        {
          title: book.title,
          authors: book.authors,
          genres: book.genres,
          description: book.description,
          shelf: book.shelves
        }
      },
      wordData:
      {
        id: nil,
        type: 'word',
        attributes:
        {
          word: nil
        }
      }
    }
  end
end
