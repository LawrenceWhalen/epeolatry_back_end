require 'rails_helper'

RSpec.describe UserBooksFacade do
  describe 'class_methods' do
    describe '.all_books' do
      before :each do
        VCR.turn_off!
        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves?key=#{Figaro.env.BOOK_KEY}").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.5.1'
           }).
          to_return(status: 200, body: File.open('./spec/assets/book_shelves.json'), headers: {})

        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes?key=#{Figaro.env.BOOK_KEY}").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.5.1'
          }).
        to_return(status: 200, body: File.open('./spec/assets/books_on_shelf.json'), headers: {})

        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/2/volumes?key=#{Figaro.env.BOOK_KEY}").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.5.1'
          }).
          to_return(status: 200, body: File.open('./spec/assets/have_read.json'), headers: {})

        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/4/volumes?key=#{Figaro.env.BOOK_KEY}").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.5.1'
          }).
        to_return(status: 200, body: File.open('./spec/assets/to_read.json'), headers: {})
      end
      it 'retrieves all a users books and creates book and shelf objects' do
        
        actual = UserBooksFacade.all_books('auth_token')
        VCR.turn_on!
        binding.pry
        expect(actual.class).to eq(Array)
        expect(actual[0].class).to eq(BookAndShelf)
      end
    end
  end
end