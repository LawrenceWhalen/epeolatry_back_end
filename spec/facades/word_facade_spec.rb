require 'rails_helper'

RSpec.describe 'word facade' do
  it 'can find a definition' do
    VCR.use_cassette 'word search' do
      result = WordFacade.define('caterwaul')

      expect(result[:definition]).to eq("[\"Make a shrill howling or wailing noise like that of a cat.\", \"A shrill howling or wailing noise.\"]")
    end
  end
  it 'can find a phonetic pronunciation guide' do
    VCR.use_cassette 'word search' do
      result = WordFacade.phonetic('caterwaul')
      phonetic = "#{"/ˈkædərˌwɔl/"}"
      expect(result[:phonetic]).to eq(phonetic)
    end
  end
end

#
# - example
#  - part of speech
#  - synonyms
#  - language
