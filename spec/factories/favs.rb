FactoryBot.define do
    factory :fav do
      user_id { Faker::Number.number(10) }
      tweet_id { Faker::Number.number(10) }
    end
end