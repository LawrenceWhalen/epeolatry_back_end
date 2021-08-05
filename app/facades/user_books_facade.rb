class UserBooksFacade

  def self.all_books(auth_token)
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

    all_books
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
