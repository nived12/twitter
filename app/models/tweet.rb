class Tweet < ApplicationRecord
  belongs_to :user
  has_many :favs, dependent: :destroy
  
  has_many :tweet_faved_user_relations, foreign_key: :user_id, class_name: 'Fav'
  has_many :tweet_favs, through: :tweet_faved_user_relations, source: :tweet_fav

  validates_presence_of :description
end
