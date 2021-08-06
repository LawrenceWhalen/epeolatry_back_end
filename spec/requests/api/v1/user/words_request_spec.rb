require 'rails_helper'

RSpec.describe 'Words Request' do

  it '#index can get all of a user\'s words' do
    VCR.turn_on!  
    sample_user_id = 1234
    sample_user_id_2 = 5678

    10.times do
      create(:word) do |word|
        create(:glossary, user_id: sample_user_id, word_id: word.id)
        create(:glossary, user_id: sample_user_id, word_id: word.id)
        create(:glossary, user_id: sample_user_id_2, word_id: word.id)
      end
    end

    5.times do
      create(:word) do |word|
        create(:glossary, user_id: sample_user_id_2, word_id: word.id)
      end
    end
      get "/api/v1/user/words?user_id=1234"

      words = JSON.parse(response.body, symbolize_names: true)[:data]


  end

  xit '#create can add a word to a user/book combo' do
    word_content = 'test'
    response_body = File.read('spec/fixtures/word_search.json')
    stub_request(:get, "https://api.dictionaryapi.dev/api/v2/entries/en_US/#{word_content}").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.6.0'
        }).
      to_return(status: 200, body: "", headers: {})

    user_id = 1
    book_id = 'ju23gs48g'
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/user/words', headers: headers, params: JSON.generate(word: word_content, volume_id: book_id, user_id: user_id)

    new_word = Word.last

    expect(response.status).to eq(201)
    expect(new_word.word).to eq(word_content)
    expect(new_word.glossaries.last.book_id).to eq(book_id)
    expect(new_word.glossaries.last.user_id).to eq(user_id)
    expect(Glossary.where('word_id = ? AND book_id = ? AND user_id = ?', new_word.id, book_id, user_id).exists?).to eq(true)
  end

  xit '#show can return a words details and the books the word is associated with' do
    sample_user_id = 1234
    sample_book_id_1 = 'm8dPPgAACAAJ'
    sample_book_id_2 = 'JhgWAQAAMAAJ'

    5.times do
      create(:word) do |word|
        create(:glossary, user_id: sample_user_id, word_id: word.id, book_id: sample_book_id_1)
        create(:glossary, user_id: sample_user_id, word_id: word.id, book_id: sample_book_id_2)
      end
    end

    sample_word = Word.last

    get "/api/v1/user/words/#{sample_word.id}"
    word_details = JSON.parse(response.body, symbolize_names: true)

    #Need to stub out responses for volume lookup

    expect(word_details.first.books.id).to eq(sample_book_id_1)
    expect(word_details.second.books.id).to eq(sample_book_id_2)
  end
end
