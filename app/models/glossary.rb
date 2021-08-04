class Glossary < ApplicationRecord
  belongs_to :word

  def self.users_words(user_id)
    where('user_id = ?', user_id).pluck(:word_id)
  end

  def self.word_stats(user_id)
    where('user_id = ?', user_id)
    
    #set as var user_glossaries
    #user_glossaries.map do |gloss|
    #Word.find(gloss[:word_id])
    #end - for array

  end
end
