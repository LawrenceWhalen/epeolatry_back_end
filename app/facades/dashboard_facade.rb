class DashboardFacade
  def self.word_stats(id)
    most_frequent = Glossary.most_frequent_word(id)
    longest_word = Glossary.longest_word(id)
    {
      most_frequent: most_frequent,
      longest_word: longest_word
    }
  end
end
