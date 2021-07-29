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
end