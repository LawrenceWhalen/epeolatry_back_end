require 'rails_helper'

RSpec.describe Glossary, type: :model do
  describe 'relationships' do
    it { should belong_to(:word) }
  end

  describe 'class methods' do
    describe '.users_words' do
      it 'returns the all word ids in the glossary for a given user' do
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

        user_1_words = Glossary.users_words(sample_user_id)
        user_2_words = Glossary.users_words(sample_user_id_2)

        expect(user_1_words.length).to eq(20)
        expect(user_2_words.length).to eq(15)
      end
    end
  end

  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
