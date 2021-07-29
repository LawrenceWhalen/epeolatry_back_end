class WordService
  def self.search(searched_word)
    response = Faraday.get"https://api.dictionaryapi.dev/api/v2/entries/en_US/#{searched_word}"
    parse(response)
  end

  def private_class_method.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
