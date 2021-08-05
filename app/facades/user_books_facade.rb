class UserBooksFacade

  def self.all_books(auth_token)
    shelves = BookService.book_shelves(auth_token)

    shelf_ids = shelves[:items].map do |shelf|
      if shelf[:title] == "Reading now" || shelf[:title] == "To read" || shelf[:title] == "Have read"
        { id: shelf[:id], title: shelf[:title] }
      end
    end.compact

    all_books = shelf_ids.map do |shelf|
      contents = BookService.books_on_shelf(shelf[:id], auth_token)[:items]
      contents.map do |book|
        BookAndShelf.new(
          g_id: book[:id],
          title: book[:volumeInfo][:title],
          authors: book[:volumeInfo][:authors],
          description: book[:volumeInfo][:description],
          genres: book[:volumeInfo][:categories],
          shelves: [shelf[:title]]
        )
      end if contents
    end.flatten

    all_books.compact.each_with_object({}) do |book, hash|
      if hash[book.g_id]
        hash[book.g_id].shelves += book.shelves
      else
        hash[book.g_id] = book
      end
    end.values
  end

  def self.single_book(auth_token, book_id)
    shelves = BookService.book_shelves(auth_token)

    shelf_ids = shelves[:items].map do |shelf|
      if shelf[:title] == "Reading now" || shelf[:title] == "To read" || shelf[:title] == "Have read"
        { id: shelf[:id], title: shelf[:title] }
      end
    end.compact
    all_books = shelf_ids.flat_map do |shelf|
      contents = BookService.books_on_shelf(shelf[:id], auth_token)[:items]
      contents.map do |book|
        BookAndShelf.new(
          g_id: book[:id],
          title: book[:volumeInfo][:title],
          authors: book[:volumeInfo][:authors],
          description: book[:volumeInfo][:description],
          genres: book[:volumeInfo][:categories],
          shelves: [shelf[:title]]
        )
      end if contents
    end

    if all_books.include?(nil)
      all_books.pop
    end

    book = all_books.find do |book|
        book.g_id == book_id
      end

    if book
      book
    else
      BookFacade.create_book_object_with_given_id(book_id)
    end
  end

  def self.add_book(shelf_id, volume_id, auth_token)
    BookService.add_book(shelf_id, volume_id, auth_token)
  end
end
