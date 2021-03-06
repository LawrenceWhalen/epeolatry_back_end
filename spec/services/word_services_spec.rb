require 'rails_helper'

RSpec.describe 'word services' do
  before :each do
    VCR.turn_on!
  end
  describe 'class methods' do
    describe '.search' do
      it 'can find english(US) words' do
        VCR.use_cassette 'word search' do
          result = WordService.search('caterwaul')
          expect(result.first[:word]).to eq('caterwaul')
          expect(result.first).to have_key(:phonetics)
          expect(result.first).to have_key(:meanings)
        end
      end
    end
  end
end


# - link to pronunciation
