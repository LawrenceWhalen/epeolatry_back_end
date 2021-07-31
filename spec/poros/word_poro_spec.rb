require 'rails_helper'

RSpec.describe 'word poro' do
  it 'has attributes' do
    fake_word = WordPoro.new(word: 'fake word', definition: "lies", phonetic: 'weird letters', phonetic_link: "https//website.sound_out", part_of_speech: 'noun because thats easy', synonyms: 'lauren boebert', example: 'why is this fake word in this test?')

    expect(fake_word.word).to eq("fake word")
    expect(fake_word.definition).to eq("lies")
    expect(fake_word.phonetic).to eq("weird letters")
    expect(fake_word.phonetic_link).to eq("https//website.sound_out")
    expect(fake_word.part_of_speech).to eq("noun because thats easy")
    expect(fake_word.synonyms).to eq("lauren boebert")
    expect(fake_word.example).to eq("why is this fake word in this test?")
  end
end
