require 'rails_helper'

RSpec.describe 'get: /books/search' do
  describe 'requesting a search' do
    it 'returns 10 books' do
      VCR.use_cassette 'search_1' do
        get '/books/search?search=sparrow'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:data].length).to eq(10)
        expect(actual[:data][0][:id]).to eq('ZXRxl3Bl2xMC')
        expect(actual[:data][0][:attributes][:title]).to eq('The Sparrow')
        expect(actual[:data][0][:attributes][:authors][0]).to eq('Mary Doria Russell')
        expect(actual[:data][0][:attributes][:genres][0]).to eq('Fiction')
        expect(actual[:data][0][:attributes][:description].include?('A visionary work')).to eq(true)
      end
    end
    it 'returns the next ten books if a page is sent' do
      VCR.use_cassette 'search_2' do
        get '/books/search?search=sparrow&page=2'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:data].length).to eq(10)
        expect(actual[:data][0][:id]).to eq('Q4BzBgAAQBAJ')
        expect(actual[:data][0][:attributes][:title]).to eq('The Wren and the Sparrow')
        expect(actual[:data][0][:attributes][:authors][0]).to eq('J. Patrick Lewis')
        expect(actual[:data][0][:attributes][:genres][0]).to eq('Juvenile Fiction')
        expect(actual[:data][0][:attributes][:description].include?('An allegorical tale')).to eq(true)
      end
    end
    it 'returns an empty array if there are no matches' do
      VCR.use_cassette 'no_match' do
        get '/books/search?search=alsdfjllskfjlasdkjflask'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:data]).to eq([])
      end
    end
    it 'returns an error if no search is provided' do
      VCR.use_cassette 'no_match' do
        get '/books/search'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:error]).to eq('No search sent')
      end
    end
  end
end