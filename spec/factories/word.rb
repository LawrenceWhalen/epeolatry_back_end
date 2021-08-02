FactoryBot.define do
  factory :word do |u|
    u.word { Faker::Lorem.characters(number: 10) }
    u.definition { Faker::Lorem.sentence }
    u.example { Faker::Lorem.sentence }
    u.part_of_speech { Faker::Lorem.characters(number: 10) }
    u.synonyms { Faker::Lorem.characters(number: 10) }
    u.phonetic { Faker::Lorem.characters(number: 5) }
    u.phonetic_link { Faker::Lorem.characters(number: 15) }
  end
end
