class BookService

  def self.book_search(search, index = 0)
    response = conn.get "/books/v1/volumes?q=#{search}&maxResults=10&orderBy=relevance&startIndex=#{index}"

    body = response.body

    search_result = JSON.parse(body, symbolize_names: true)
    if search_result[:items]
      search_result[:items]
    else
      []
    end
  end

  def self.book_shelves(auth_token)
    response = conn(auth_token).get "/books/v1/mylibrary/bookshelves"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.books_on_shelf(shelf, auth_token)
    response = conn(auth_token).get "/books/v1/mylibrary/bookshelves/#{shelf}/volumes"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.add_book(shelf_id, volume_id, auth_token)
    response = conn(auth_token).post "/books/v1/mylibrary/bookshelves/#{shelf_id}/addVolume?volumeId=#{volume_id}"
  end

  def self.remove_book(shelf_id, volume_id, auth_token)
    conn(auth_token).post "/books/v1/mylibrary/bookshelves/#{shelf_id}/removeVolume?volumeId=#{volume_id}"
  end

  def self.volume_lookup(book_id)
    response = conn.get("/books/v1/volumes/#{book_id}")

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn(auth_token = nil)
    Faraday.new(url: 'https://books.googleapis.com') do |faraday|
      faraday.headers[:Authorization] = "Bearer #{auth_token}"
      # faraday.params[:key] = ENV['BOOK_KEY']
        # 8/2/21 - not sure why, but this breaks functionality in development.
        # All calls work without it - to revisit if needed.
    end
  end
end
