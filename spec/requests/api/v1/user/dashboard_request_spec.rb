require 'rails_helper'

RSpec.describe 'Dashboard Request' do
  before :each do
    user_id = 4321
    frequent = Word.create(word: 'frequent', definition: 'often, of many times',
      example: 'The staff knew her well, as she would frequent the shop.',
      part_of_speech: 'merp', synonyms: 'mlerp', phonetic: 'muh-ler-p', phonetic_link: 'link here')
    short = Word.create(word: 'shortestwordeverontheplanet', definition: 'little length', example: 'she was very
      short and asked for help to reach the top shelf', part_of_speech: 'merp', synonyms: 'mlerp',
      phonetic: 'muh-ler-p', phonetic_link: 'link here')

    sample_book_1 = {
                    g_id: 111111111111,
                    title: "This is a Real Book",
                    authors: "I am the Writer",
                    genres: "Nonfiction",
                    description: "A very interesting, non-fictional, really written book."
                    }

    sample_book_2 = {
                    g_id: 222222222222,
                    title: "This is a very Fictional Unreal Book",
                    authors: "Baxter Willoughby",
                    genres: "Fiction",
                    description: "The adventures of Baxter."
                    }
    3.times do
      create(:word) do |word|
        create(:glossary, book_id: sample_book_1[:g_id], user_id: user_id, word_id: word.id)
      end
    end

    4.times do
      create(:word) do |word|
        create(:glossary, book_id: sample_book_2[:g_id], user_id: user_id, word_id: word.id)
      end
    end

      create(:glossary, book_id: sample_book_2[:g_id], user_id: user_id, word_id: short.id)
      create(:glossary, book_id: sample_book_1[:g_id], user_id: user_id, word_id: frequent.id)
      create(:glossary, book_id: sample_book_2[:g_id], user_id: user_id, word_id: frequent.id)

    get "/api/v1/user/dashboard?user_id=#{user_id}"
    @word_stats = JSON.parse(response.body, symbolize_names: true)
  end

  it 'returns average words saved per book' do
    expect(@word_stats[:avg_per_book]).to eq(5)
  end

  it 'returns words most frequently added by reader' do
    expect(@word_stats[:most_frequent][0][:word]).to eq('frequent')
  end

  it 'returns searched word with longest length' do
    expect(@word_stats[:longest_word]).to eq('shortestwordeverontheplanet')
  end
end
