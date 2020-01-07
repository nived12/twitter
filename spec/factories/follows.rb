FactoryBot.define do
    factory :follow do
      user_id { Faker::Number.number(10) }
      following_id { Faker::Number.number(10) }
      #user_id nil
    end
end