class HomeController < ApplicationController
    before_action :tweets, only: :index
    def index
        json_response(tweets)
    end

    private
    def tweets
        #El join :user no se requiere ahorita, pero es para realizar un query con informacion de tweets y users
        #Tweet.joins(:user).where("user_id = ? OR user_id IN (?)", @current_user.id, @current_user.followings.ids) 
        Tweet.where("user_id = ? OR user_id IN (?)", @current_user.id, @current_user.followings.ids)    
    end
end
