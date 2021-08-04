require 'rails_helper'

RSpec.describe 'book service' do
  describe 'class methods' do
    before :each do
      VCR.turn_on!
    end

    describe '.book_search' do
      it 'returns a list of books that match by title' do
        VCR.use_cassette 'sparrow_1' do
          actual = BookService.book_search('sparrow')

          expect(actual.length).to eq(10)
          expect(actual[0][:id]).to eq('ZXRxl3Bl2xMC')
          expect(actual[0][:volumeInfo][:title]).to eq('The Sparrow')
          expect(actual[0][:volumeInfo][:authors][0]).to eq('Mary Doria Russell')
          expect(actual[0][:volumeInfo][:categories][0]).to eq('Fiction')
          expect(actual[0][:volumeInfo][:description].include?('A visionary work')).to eq(true)
        end
      end

      it 'can return addtional results based on search page number' do
        VCR.use_cassette 'sparrow_2' do
          actual = BookService.book_search('sparrow', 10)

          expect(actual.length).to eq(10)
          expect(actual[0][:id]).to eq('LTXZgvsxvtsC')
          expect(actual[0][:volumeInfo][:title]).to eq('Children of God')
          expect(actual[0][:volumeInfo][:authors][0]).to eq('Mary Doria Russell')
          expect(actual[0][:volumeInfo][:categories][0]).to eq('Fiction')
          expect(actual[0][:volumeInfo][:description].include?('In Children of God, Mary')).to eq(true)
        end
      end

      it 'returns an empty array if nothing matches the search' do
        VCR.use_cassette 'no_match' do
          actual = BookService.book_search('alsdfjllskfjlasdkjflask')

          expect(actual).to eq([])
        end
      end
    end

    describe '.book_shelves' do
      it 'returns a list of all of a users bookshelves' do
        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves")
          .to_return(status: 200, body: File.open('./spec/assets/book_shelves.json').read, headers: {})

        VCR.turn_off!
          actual = BookService.book_shelves('auth_token')
        VCR.turn_on!

        expect(actual.class).to eq(Hash)
        expect(actual[:items][0][:id]).to eq(7)
        expect(actual[:items][1][:id]).to eq(1)
      end
    end

    describe '.books_on_shelf' do
      it 'returns all of the books off a users shelf' do
        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes")
          .to_return(status: 200, body: File.open('./spec/assets/books_on_shelf.json').read, headers: {})

        VCR.turn_off!
          actual = BookService.books_on_shelf(3, 'auth_token')
        VCR.turn_on!

        expect(actual.class).to eq(Hash)
        expect(actual[:items][0][:id]).to eq('PCcOMbEydAIC')
        expect(actual[:items][1][:id]).to eq('ZrNzAwAAQBAJ')
      end
    end

    describe '.add_book' do
      it 'adds a book to the shelf of a user' do
        shelf_id = 4
        volume_id = 'm8dPPgAACAAJ'

        stub_request(:post, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/#{shelf_id}/addVolume?volumeId=#{volume_id}")
          .to_return(status: 200, body: "{}", headers: {})

        VCR.turn_off!
          actual = BookService.add_book(shelf_id, volume_id, 'auth_token')
        VCR.turn_on!

        expect(actual.status).to eq(200)
        expect(actual.body).to eq("{}")
      end
    end

    describe '.remove_book' do
      it 'can remove a book from a users shelf' do
        shelf_id = 4
        volume_id = "inYs79gV4UQC"

        stub_request(:post, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/#{shelf_id}/removeVolume?volumeId=#{volume_id}")
          .to_return(status: 200, body: '{}', headers: {})

        VCR.turn_off!
          actual = BookService.remove_book(shelf_id, volume_id, 'auth_token')
        VCR.turn_on!

        expect(actual.status).to eq(200)
        expect(actual.body).to eq("{}")
      end
    end
  end
end
