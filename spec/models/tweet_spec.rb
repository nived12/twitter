require 'rails_helper'

RSpec.describe Tweet, type: :model do
  # Association test
  # ensure a Tweet record belongs to a single user record
  it { should belong_to(:user) }
  it { should have_many(:favs).dependent(:destroy) }
  
  it { should have_many(:tweet_faved_user_relations).with_foreign_key(:user_id).class_name('Fav') }
  it { should have_many(:tweet_favs).through(:tweet_faved_user_relations).source(:tweet_fav) }

  # Validation test
  # ensure column description is present before saving
  it { should validate_presence_of(:description) }
end
