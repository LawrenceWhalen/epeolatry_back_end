class DashboardSerializer

  def self.word_stats(most_frequent, longest)
    {
      most_frequent: most_frequent[0][:word],
      longest_word: longest
    }
  end
end
