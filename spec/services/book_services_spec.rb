require 'rails_helper'

RSpec.describe 'book service' do
  describe 'class methods' do
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
          expect(actual[0][:id]).to eq('MRm8DwAAQBAJ')
          expect(actual[0][:volumeInfo][:title]).to eq('Silver Sparrow')
          expect(actual[0][:volumeInfo][:authors][0]).to eq('Tayari Jones')
          expect(actual[0][:volumeInfo][:categories][0]).to eq('Fiction')
          expect(actual[0][:volumeInfo][:description].include?('A breathtaking tale')).to eq(true)
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
        VCR.turn_off!
        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves?key=AIzaSyA2pg4G1iDnNU0qxOvhl8hi3ZJBjjc_yJw").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.5.1'
           }).
         to_return(status: 200, body: File.open('./spec/assets/book_shelves.json'), headers: {})

        actual = BookService.book_shelves

        expect(actual.class).to eq(Hash)
        expect(actual[:items][0][:id]).to eq(7)
        expect(actual[:items][1][:id]).to eq(1)
        VCR.turn_on!
      end
    end
    
    describe '.get_shelfs_books' do
      it 'returns all of the books off a users shelf' do
        VCR.turn_off!
        stub_request(:get, "https://books.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes?key=AIzaSyA2pg4G1iDnNU0qxOvhl8hi3ZJBjjc_yJw").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.5.1'
           }).
         to_return(status: 200, body: File.open('./spec/assets/books_on_shelf.json'), headers: {})

        actual = BookService.books_on_shelf(3)

        expect(actual.class).to eq(Hash)
        expect(actual[:items][0][:id]).to eq('PCcOMbEydAIC')
        expect(actual[:items][1][:id]).to eq('ZrNzAwAAQBAJ')
        VCR.turn_on!
      end
    end
  end
end