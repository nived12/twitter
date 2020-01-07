class Fav < ApplicationRecord
  belongs_to :user_fav, foreign_key: 'user_id', class_name: 'User'
  belongs_to :tweet_fav, foreign_key: 'tweet_id', class_name: 'Tweet'

  validates :user_id, uniqueness: { scope: :tweet_id, message: "You have already favorited it." }
end
