class RemoveFavFromTweets < ActiveRecord::Migration[6.0]
  def change
    remove_column :tweets, :fav, :boolean
  end
end
