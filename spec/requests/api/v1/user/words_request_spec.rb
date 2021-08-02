require 'rails_helper'

RSpec.describe 'Words Request' do
  it 'can get all of a user\'s words' do
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

    get "/api/v1/user/words?user_id=#{sample_user_id}"
    words = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(words.count).to eq(10)
  end

  it 'can add a word to a user/book combo' do
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
end
