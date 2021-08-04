require 'rails_helper'

RSpec.describe 'Books Request' do
  before :each do
    VCR.turn_off!
    stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves")
      .to_return(status: 200, body: File.open('./spec/assets/book_shelves.json'), headers: {})

    stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes")
      .to_return(status: 200, body: File.open('./spec/assets/books_on_shelf.json'), headers: {})

    stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/2/volumes")
      .to_return(status: 200, body: File.open('./spec/assets/have_read.json'), headers: {})

    stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/4/volumes")
      .to_return(status: 200, body: File.open('./spec/assets/to_read.json'), headers: {})
  end

  describe 'controller index action' do
    describe 'return value' do
      it 'returns a collection of BookAndShelf objects' do
        get '/api/v1/user/books'

        actual = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(actual.class).to eq(Array)
        expect(actual[0][:attributes][:title]).to_not eq(nil)
        expect(actual[0][:id]).to_not eq(nil)
        expect(actual[0][:attributes][:authors]).to_not eq(nil)
        expect(actual[0][:attributes][:description]).to_not eq(nil)
        expect(actual[0][:attributes][:genres]).to_not eq(nil)
        expect(actual[0][:attributes][:shelves]).to_not eq(nil)
      end
    end
  end

  describe 'controller create action' do
    xit '#create adds a book to a library' do
      # how to test this functionality while mocking?
      get '/api/v1/user/books'
      initial_count = JSON.parse(response.body, symbolize_names: true)[:data].length

      volume_id = 'm8dPPgAACAAJ'
      post "/api/v1/user/books?volume_id=#{volume_id}"
      get '//api/v1/user/books'

      final_count = JSON.parse(response.body, symbolize_names: true)[:data].length

      expect(final_count - initial_count).to eq(1)
    end
  end
end
