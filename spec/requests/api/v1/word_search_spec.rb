require 'rails_helper'

RSpec.describe 'Word Search' do
  describe 'requesting a search' do
    xit 'returns quested info' do
      VCR.use_cassette 'definition search' do
        # get "/words/search?q=caterwaul"
        get api_v1_word_search_path(q:'caterwaul')
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data][:attributes][:word]).to eq('caterwaul')
      end
    end
  end
end
