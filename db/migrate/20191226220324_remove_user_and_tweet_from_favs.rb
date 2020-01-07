class RemoveUserAndTweetFromFavs < ActiveRecord::Migration[6.0]
  def change
    remove_column :favs, :user, :references
    remove_column :favs, :tweet, :references
  end
end
