require 'rails_helper'

RSpec.describe UserBooksFacade do
  describe 'class_methods' do
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

    describe '.all_books' do
      it 'retrieves all a users books and creates book and shelf objects' do
        actual = UserBooksFacade.all_books('auth_token')

        expect(actual.class).to eq(Array)
        expect(actual[0].class).to eq(BookAndShelf)
      end
    end

    describe 'single_book' do
      it 'returns a single book' do
        response = UserBooksFacade.single_book('auth_token', 'ZrNzAwAAQBAJ')

        # stub_request(:get, "https://books.googleapis.com/books/v1/volumes/vTsPAAAAYAAJ").
        # to_return(status: 200, body: File.read('spec/fixtures/tale_search.json'), headers: {})
        #
        # other_response = UserBooksFacade.single_book('auth_token', 'vTsPAAAAYAAJ')

      end
    end

    describe '.add_book' do
      xit '.add_book adds a book to the user\'s library' do
        # how to test this functionality while mocking?
        initial_count = UserBooksFacade.all_books('auth_token').length

        volume_id = 'm8dPPgAACAAJ'
        UserBooksFacade.add_book(volume_id, 'auth_token')

        final_count = UserBooksFacade.all_books('auth_token').length

        expect(final_count - initial_count).to eq(1)
      end
    end
  end
end
