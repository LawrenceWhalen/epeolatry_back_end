require 'rails_helper'

RSpec.describe 'Words Request' do
  xit 'can show all of a user\'s words' do
    get api_v1_user_words_path

    words = JSON.parse(response.body, symbolize_names: true)


  end

  it 'can add a word to a user/book combo' do
    user_id = 1
    book_id = 'ju23gs48g'
    # new_word = Word.create!(word: "test",
    #                     definition: "an sample item used for testing",
    #                     example: "this is a test",
    #                     part_of_speech: "noun",
    #                     synonyms: ["example", "sample"],
    #                     phonetic: 't-eeee-zt',
    #                     phonetic_link: 'www.google.com')
    word_content = 'test'
    headers = {"CONTENT_TYPE" => "application/json"}

    post '/api/v1/user/words', headers: headers, params: JSON.generate(word: word_content, volume_id: book_id, user_id: user_id)

    new_word = Word.last

    expect(response).to be_successful
    expect(new_word.word).to eq(word_content)
    expect(Glossary.where('word_id = ?, book_id = ?, user_id = ?', new_word.id, book_id, user_id).exists?).to eq(true)
  end
end
