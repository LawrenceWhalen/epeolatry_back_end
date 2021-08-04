class Glossary < ApplicationRecord
  belongs_to :word

  def self.users_words(user_id)
    where('user_id = ?', user_id).pluck(:word_id)
  end
end
