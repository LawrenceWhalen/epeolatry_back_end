FactoryBot.define do
  factory :book_poro do |u|
    u.g_id { Faker::Number.number(digits: 12) }
    u.title { Faker::Book.title }
    u.authors { [Faker::Book.author] }
    u.genres { [Faker::Book.genre, Faker::Book.genre] }
    u.description { Faker::Lorem.sentence }
  end
end