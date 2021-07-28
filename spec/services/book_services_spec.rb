require 'rails_helper'

RSpec.describe 'book service' do
  xit 'can find books' do
    VCR.use_cassette 'book_search' do

    end

  end

  xit 'can find words in book' do
    VCR.use_cassette 'word_search' do

    end
  end
end
