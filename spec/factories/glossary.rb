FactoryBot.define do
  factory :glossary do |u|
    u.word_id { Faker::Lorem.characters(number: 5, min_numeric: 5) }
    u.book_id { Faker::Lorem.characters(number: 10, min_numeric: 3) }
    u.user_id { Faker::Lorem.characters(number: 5, min_numeric: 5) }
  end
end
