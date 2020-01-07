require 'rails_helper'

RSpec.describe User, type: :model do
  # ensure User model has a 1:m relationship with the Tweet model
  it { should have_many(:tweets).dependent(:destroy) }
  it { should have_many(:follows).dependent(:destroy) }
  it { should have_many(:favs).dependent(:destroy) }

  it { should have_many(:follower_relations).with_foreign_key(:following_id).class_name('Follow') }
  it { should have_many(:followers).through(:follower_relations).source(:follower) }

  it { should have_many(:following_relations).with_foreign_key(:user_id).class_name('Follow') }
  it { should have_many(:followings).through(:following_relations).source(:following) }

  it { should have_many(:user_fav_tweet_relations).with_foreign_key(:tweet_id).class_name('Fav') }
  it { should have_many(:user_favs).through(:user_fav_tweet_relations).source(:user_fav) }

  #it { should have_one(:home) }
  
  # Validation tests
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  it { validate_uniqueness_of(:username).with_message('already exists') }
  it { validate_uniqueness_of(:email).with_message('already exists') }
end
