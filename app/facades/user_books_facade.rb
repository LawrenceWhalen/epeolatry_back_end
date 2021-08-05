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
    shelf_ids = {3 =>"Reading now", 2=>"To read", 4=>"Have read"}

    all_book_ids = []
    all_books = []
    shelf_ids.keys.each do |shelf_id|
      shelf_contents = BookService.books_on_shelf(shelf_id, auth_token)[:items]

      if !shelf_contents.nil?
        shelf_contents.map do |book|
          if all_book_ids.include?(book[:id])
            added_book = all_books.find do |added_book|
              added_book.g_id == book[:id]
            end
            added_book.shelves << shelf_ids[shelf_id]
          else
            book = BookAndShelf.new(
              g_id: book[:id],
              title: book[:volumeInfo][:title],
              authors: book[:volumeInfo][:authors],
              description: book[:volumeInfo][:description],
              genres: book[:volumeInfo][:categories],
              shelves: [shelf_ids[shelf_id]]
            )
            all_book_ids << book.g_id
            all_books << book
          end
        end
      end
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
