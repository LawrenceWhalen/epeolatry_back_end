require 'rails_helper'

RSpec.describe 'get: user/books' do
  describe 'controller index action' do
    describe 'return value' do
      before :each do
        VCR.turn_off!
        key = Figaro.env.BOOK_KEY
        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves?key=#{key}").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.5.1'
           }).
          to_return(status: 200, body: File.open('./spec/assets/book_shelves.json'), headers: {})

        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes?key=#{key}").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.5.1'
          }).
        to_return(status: 200, body: File.open('./spec/assets/books_on_shelf.json'), headers: {})

        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/2/volumes?key=#{key}").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.5.1'
          }).
          to_return(status: 200, body: File.open('./spec/assets/have_read.json'), headers: {})

        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/4/volumes?key=#{key}").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.5.1'
          }).
        to_return(status: 200, body: File.open('./spec/assets/to_read.json'), headers: {})
      end
      it 'returns a collection of BookAndShelf objects' do
        get '/user/books'

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
end