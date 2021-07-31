class BookService

  def self.book_search(search, index = 0)
    response = con.get "/books/v1/volumes?q=#{search}&maxResults=10&orderBy=relevance&startIndex=#{index}"

    body = response.body

    search_result = JSON.parse(body, symbolize_names: true)
    if search_result[:items]
      search_result[:items]
    else
      []
    end
  end

  def self.book_shelves(auth_token)
    response = con(auth_token).get "/books/v1/mylibrary/bookshelves"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.books_on_shelf(shelf, auth_token)
    response = con(auth_token).get "/books/v1/mylibrary/bookshelves/#{shelf}/volumes"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.add_book(volume_id, auth_token)
    shelf =  BookService.book_shelves(auth_token)[:items].find do |shelf|
                shelf[:title] == "To read"
              end
    shelf_id = shelf[:id]

    con(auth_token).get "/books/v1/mylibrary/bookshelves/#{shelf_id}/addVolume?volumeId=#{volume_id}"
  end

  private

  def self.con(auth_token = nil)
    Faraday.new(url: 'https://books.googleapis.com') do |faraday|
      faraday.params[:key] = Figaro.env.BOOK_KEY
      faraday.headers[:Authorization] = "Bearer #{auth_token}"
    end
  end
end
