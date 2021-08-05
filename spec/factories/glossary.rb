FactoryBot.define do
  factory :glossary do |u|
    u.word_id { Faker::Lorem.characters(number: 5, min_numeric: 5) }
    u.book_id { ['PCcOMbEydAIC', '8thMLkahggcC', 'Y7sOAAAAIAAJ', 'ZrNzAwAAQBAJ', 'inYs79gV4UQC', 'B4d1swEACAAJ'].sample }
    u.user_id { Faker::Lorem.characters(number: 5, min_numeric: 5) }
  end
end
