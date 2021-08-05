require 'rails_helper'

RSpec.describe 'user words facade' do
  describe 'class methods' do
    describe '.create_word' do
      before :each do
        word_content = 'test'
        response_body = File.read('spec/fixtures/word_search.json')
        stub_request(:get, "https://api.dictionaryapi.dev/api/v2/entries/en_US/#{word_content}").
          with(
            headers: {
                     'Accept'=>'*/*',
                     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'User-Agent'=>'Faraday v1.5.1'
                      }).
          to_return(status: 200, body: response_body, headers: {})

          non_word = 'gte'
          response_body2 = File.read('spec/fixtures/word_search_fail.json')
          stub_request(:get, "https://api.dictionaryapi.dev/api/v2/entries/en_US/#{non_word}").
            with(
              headers: {
                       'Accept'=>'*/*',
                       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                       'User-Agent'=>'Faraday v1.5.1'
                        }).
            to_return(status: 200, body: response_body2, headers: {})
      end

      it 'looks up a word and returns a word object with response' do
        input_word = 'test'

        VCR.use_cassette 'create_word_test' do
          UserWordsFacade.create_word(input_word)
        end
        
        new_word = Word.last
        expect(new_word.word).to eq(input_word)
        expect(new_word.definition).to eq("Take measures to check the quality, performance, or reliability of (something), especially before putting it into widespread use or practice.")
        expect(new_word.phonetic).to eq("/tɛst/")
        expect(new_word.phonetic_link).to eq("https://lex-audio.useremarkable.com/mp3/test_us_1.mp3")
        expect(new_word.part_of_speech).to eq("transitive verb")
        expect(new_word.example).to eq("this range has not been tested on animals")
        # expect(new_word.synonyms.length).to eq(7) #need to manipulate this output into useable array
        # expect(new_word.synonyms.first).to eq("try out")
      end

      it 'does not add word if word not found' do
        non_word = 'gte'
        pre_word_count = Word.all.count
        VCR.use_cassette 'not_a_word' do
          @output = UserWordsFacade.create_word(non_word)
        end
        post_word_count = Word.all.count

        expect(@output).to eq("Sorry pal, we couldn't find definitions for the word you were looking for. You can try the search again at later time or head to the web instead.")
        expect(post_word_count - pre_word_count).to eq(0)
      end
    end
  end
end
