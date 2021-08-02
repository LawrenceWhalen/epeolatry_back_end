class WordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :word, :definition, :phonetic, :phonetic_link, :part_of_speech, :synonyms, :example
end
