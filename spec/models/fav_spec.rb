require 'rails_helper'

RSpec.describe Fav, type: :model do
  # let!(:user) { create(:user) }
  # let!(:tweet) { create(:tweet) }
  # subject { Fav.new(user: User.last, tweet: Tweet.last) }

  
  # Association test
  it { should belong_to(:user_fav).with_foreign_key(:user_id).class_name('User') }
  it { should belong_to(:tweet_fav).with_foreign_key(:tweet_id).class_name('Tweet') }

  # it { should belong_to(:user) }
  # it { should belong_to(:tweet) }
  
  #it { should validate_uniqueness_of(:user_id).scoped_to(:tweet_id).with_message("You have already favorite it.") }
  
end
