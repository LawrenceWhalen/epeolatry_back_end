require 'rails_helper'

RSpec.describe 'book service' do
  describe 'class methods' do
    describe '.book_search' do
      it 'returns a list of books that match by title' do
        VCR.use_cassette 'sparrow_1' do
          actual = BookService.book_search('sparrow')

          expect(actual.length).to eq(10)
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
          expect(actual[0][:volumeInfo][:title]).to eq('Silver Sparrow')
          expect(actual[0][:volumeInfo][:authors][0]).to eq('Tayari Jones')
          expect(actual[0][:volumeInfo][:categories][0]).to eq('Fiction')
          expect(actual[0][:volumeInfo][:description].include?('A breathtaking tale')).to eq(true)
        end
      end
    end
  end
end