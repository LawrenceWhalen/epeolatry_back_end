require 'rails_helper'

RSpec.describe 'word poro' do
  it 'has attributes' do
    fake_word = Word.new(definition: "Lies", phonetic: 'weird letters', part_of_speech: 'noun because thats easy', synonyms: 'lauren boebert', example: 'why is this fake word in this test?')

    expect(fake_word.definition).to eq("lies")
    expect(fake_word.phonetic).to eq("weird letters")
    expect(fake_word.part_of_speech).to eq("noun because thats easy")
    expect(fake_word.synonyms).to eq("lauren boebert")
    expect(fake_word.definition).to eq("why is this fake word in this test?")
  end
end
