require 'rails_helper'

RSpec.describe BookFacade do
  describe 'class methods' do
    describe 'title_search' do
      it 'returns 10 books by title' do
        VCR.use_cassette 'sparrow_1' do
          actual = BookFacade.title_search('sparrow')

          expect(actual.length).to eq(10)
          expect(actual[0].class).to eq(BookPoro)
          expect(actual[0].g_id).to eq('ZXRxl3Bl2xMC')
          expect(actual[0].title).to eq('The Sparrow')
          expect(actual[0].authors).to eq(['Mary Doria Russell'])
          expect(actual[0].genres).to eq(['Fiction'])
          expect(actual[0].description.include?('A visionary work')).to eq(true)
        end
      end
      it 'returns the next ten books if page 2 is sent' do
        VCR.use_cassette 'sparrow_2' do
          actual = BookFacade.title_search('sparrow', 10)

          expect(actual.length).to eq(10)
          expect(actual[0].class).to eq(BookPoro)
          expect(actual[0].g_id).to eq('MRm8DwAAQBAJ')
          expect(actual[0].title).to eq('Silver Sparrow')
          expect(actual[0].authors).to eq(['Tayari Jones'])
          expect(actual[0].genres).to eq(['Fiction'])
          expect(actual[0].description.include?('A breathtaking tale')).to eq(true)
        end
      end
    end
  end
end