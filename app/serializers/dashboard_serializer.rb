class DashboardSerializer

  def self.word_stats(word_stats)
    {
      avg_per_book: word_stats[:avg_per_book],
      most_frequent: word_stats[:most_frequent],
      longest_word: word_stats[:longest_word]
    }
  end
end
