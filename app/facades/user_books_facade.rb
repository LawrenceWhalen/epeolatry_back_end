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
          shelves: shelf[:title]
        )
      end if contents
    end
    test = all_books.flatten.each_with_object({}) do |book, hash|
      if hash[book.g_id]
        hash[book.g_id].shelves.merge!(book.shelves)
      else
        hash[book.g_id] = book
      end
    end
    binding.pry
  end

end