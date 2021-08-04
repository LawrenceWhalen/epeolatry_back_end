require 'rails_helper'

RSpec.describe 'Book Search' do
  describe 'requesting a search' do
    before :each do
      VCR.turn_on!
    end
    it 'returns 10 books' do
      VCR.use_cassette 'search_1' do
        get '/api/v1/book/search?search=sparrow'

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
        get '/api/v1/book/search?search=sparrow&page=2'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:data].length).to eq(10)
        expect(actual[:data][0][:id]).to eq('LTXZgvsxvtsC')
        expect(actual[:data][0][:attributes][:title]).to eq('Children of God')
        expect(actual[:data][0][:attributes][:authors][0]).to eq('Mary Doria Russell')
        expect(actual[:data][0][:attributes][:genres][0]).to eq('Fiction')
        expect(actual[:data][0][:attributes][:description].include?('In Children of God, Mary')).to eq(true)
      end
    end
    it 'returns an empty array if there are no matches' do
      VCR.use_cassette 'no_match' do
        get '/api/v1/book/search?search=alsdfjllskfjlasdkjflask'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:data]).to eq([])
      end
    end
    it 'returns an error if no search is provided' do
      VCR.use_cassette 'no_match' do
        get '/api/v1/book/search'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:error]).to eq('No search sent')
      end
    end
  end

  describe 'show searched book' do
    it 'can show a book that has been searched for' do
      VCR.use_cassette 'search_1' do
        get api_v1_book_search_path(search:'sparrow')
      end

      actual = JSON.parse(response.body, symbolize_names: true)

      expect(actual[:data].length).to eq(10)
      expect(actual[:data][0][:id]).to eq('ZXRxl3Bl2xMC')
      expect(actual[:data][0][:attributes][:title]).to eq('The Sparrow')
      expect(actual[:data][0][:attributes][:authors][0]).to eq('Mary Doria Russell')

      get api_v1_book_show_path
    end
  end
end
