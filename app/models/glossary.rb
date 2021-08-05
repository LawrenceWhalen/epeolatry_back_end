class Glossary < ApplicationRecord
  belongs_to :word

  def self.users_words(user_id)
    where('user_id = ?', user_id).pluck(:word_id)
  end

  def self.find_books(word_ids, user_id)
    word_ids.uniq.map do |word|
      self.select(:word_id, :book_id).
      where('glossaries.word_id = ? AND glossaries.user_id = ?', word, user_id).
      order('book_id')
    end
  end
end
