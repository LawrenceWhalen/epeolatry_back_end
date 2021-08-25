class DashboardFacade
  def self.word_stats(id)
    if Glossary.where('user_id = ?', id).count >= 1
      avg_per_book = Glossary.avg_per_book(id)
      most_frequent = Glossary.most_frequent_word(id)
      longest_word = Glossary.longest_word(id)
        {
          avg_per_book: avg_per_book,
          most_frequent: most_frequent,
          longest_word: longest_word
        }
    else
      avg_per_book = "You haven't added any words yet"
      most_frequent = "You haven't added any words yet"
      longest_word = "You haven't added any words yet"
      {
        avg_per_book: avg_per_book,
        most_frequent: most_frequent,
        longest_word: longest_word
      }
    end
  end
end
