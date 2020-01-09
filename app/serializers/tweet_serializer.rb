class TweetSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at, :fav_tweet
  
  # has_many :favs
  def fav_tweet
    { favs: object.favs.ids.count }    
  end

end
