class DashboardFacade
  def self.word_stats(id)
    avg_per_book = Glossary.avg_per_book(id)
    most_frequent = Glossary.most_frequent_word(id)
    longest_word = Glossary.longest_word(id)
    {
      avg_per_book: avg_per_book,
      most_frequent: most_frequent,
      longest_word: longest_word
    }
  end
end
