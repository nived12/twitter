class User < ApplicationRecord
    #encrypt password
    has_secure_password
    
    has_many :tweets, dependent: :destroy
    #has_many :fav_tweets, through: :favs, foreign_key: "tweet_id", source: :tweet, dependent: :destroy
    has_many :follows, dependent: :destroy
    has_many :favs, dependent: :destroy

    has_many :follower_relations, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :follower_relations, source: :follower

    has_many :following_relations, foreign_key: :user_id, class_name: 'Follow'
    has_many :followings, through: :following_relations, source: :following

    has_many :user_fav_tweet_relations, foreign_key: :tweet_id, class_name: 'Fav'
    has_many :user_favs, through: :user_fav_tweet_relations, source: :user_fav

    validates_presence_of :username, :email, :password_digest

    validates :username, uniqueness: { message: "already exist" } 
    validates :email, uniqueness: { message: "already exist" }
end
