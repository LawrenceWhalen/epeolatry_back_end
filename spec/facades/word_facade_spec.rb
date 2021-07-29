require 'rails_helper'

RSpec.describe 'word facade' do
  it 'can find a definition' do
    VCR.use_cassette 'word search' do
      result = WordFacade.word_search('caterwaul')

      expect(result[:definition]).to eq("Make a shrill howling or wailing noise like that of a cat.")
      expect(result[:phonetic]).to eq("/ˈkædərˌwɔl/")
      expect(result[:part_of_speech]).to eq('intransitive verb')
    end
  end
end
