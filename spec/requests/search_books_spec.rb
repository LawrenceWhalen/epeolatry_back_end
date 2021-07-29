require 'rails_helper'

RSpec.describe 'get: /books/search' do
  describe 'requesting a search' do
    it 'returns 10 books' do
      VCR.use_cassette 'sparrow_1' do
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
  end
end