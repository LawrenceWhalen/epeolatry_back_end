class BookFacade
  def self.title_search(search, index = 0)
    books = BookService.book_search(search, index)
    if books == []
      []
    else
      books.map do |book|
        BookPoro.new(g_id: book[:id],
                    title: book[:volumeInfo][:title],
                    authors: book[:volumeInfo][:authors],
                    genres: book[:volumeInfo][:categories],
                    description: book[:volumeInfo][:description])
      end
    end
  end

  def self.create_book_object_with_given_id(book_id)
    json = BookService.volume_lookup(book_id)

    BookPoro.new(json)
  end
end
