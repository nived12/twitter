class Follow < ApplicationRecord
    belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
    belongs_to :following, foreign_key: 'following_id', class_name: 'User'

    validates_uniqueness_of :follower, scope: :following, message: "You have already followed it."
    # validates_presence_of :user_id
    # validates_presence_of :following_id
end
