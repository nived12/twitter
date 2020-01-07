require 'rails_helper'

RSpec.describe Follow, type: :model do
  it { should belong_to(:follower).with_foreign_key('user_id').class_name('User') }
  it { should belong_to(:following).with_foreign_key('following_id').class_name('User') }
  
  # it { should validate_uniqueness_of(:follower).scoped_to(:following).with_message("You have already followed that user.") }

end
