class HomesController < ApplicationController
    before_action :tweets, only: :index
    def index
        #binding.pry
        json_response(tweets)
        #json_response(@tweet_cUser)
    end

    private
    def tweets
        #binding.pry
        tweet_cUser = @current_user.tweets
        tweet_users = Tweet.where(user_id: @current_user.followings.ids).all
        @tweets= tweet_cUser + tweet_users
    end
end
