class WordWithBooksSerializer
  include FastJsonapi::ObjectSerializer
  set_id :word
  attributes :word, :definition, :phonetic, :phonetic_link, :part_of_speech, :synonyms, :example, :books
end
