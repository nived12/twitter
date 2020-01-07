FactoryBot.define do
    factory :tweet do
      description { Faker::Sports::Football.player }
      user_id nil
    end
  end