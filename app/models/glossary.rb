class Glossary < ApplicationRecord
  belongs_to :word

  def self.users_words(user_id)
    where('user_id = ?', user_id).pluck(:word_id)
  end

  def self.most_frequent_word(user_id)
    word_ids = self.users_words(user_id)
    id = word_ids.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    Word.find(id)
  end

  def self.avg_per_book(user_id)
    all_user_words = Glossary.all
    by_book = {}
    all_user_words.map do |word|
      if by_book[word.book_id].nil?
        by_book[word.book_id] = 1
      else
        by_book[word.book_id] += 1
      end
    end
    by_book.values.sum/by_book.keys.count
  end

  def self.longest_word(user_id)
    word_ids = self.users_words(user_id)
    words = Word.find(word_ids)
    list = []
    words.map do |word|
      list << word[:word]
    end
    list.sort {|l, r| r.length <=> l.length}.first
  end




  # def self.word_stats(user_id)
  #   where('user_id = ?', user_id)
  # end
end
