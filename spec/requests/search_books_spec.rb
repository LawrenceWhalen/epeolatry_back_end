require 'rails_helper'

RSpec.describe 'get: /books/search' do
  describe 'requesting a search' do
    it 'returns 10 books' do
      VCR.use_cassette 'sparrow_1' do
        get '/books/search?search=sparrow'

        actual = JSON.parse(response.body, symbolize_names: true)
        
        expect(actual.length).to eq(10)
      end
    end
  end
end