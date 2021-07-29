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

  def self.book_shelves
    response = con.get "/books/v1/mylibrary/bookshelves"

    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  private

  def self.con
    Faraday.new(url: 'https://books.googleapis.com') do |faraday|
      faraday.params[:key] = Figaro.env.BOOK_KEY
    end
  end
end