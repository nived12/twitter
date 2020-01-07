class FavsController < ApplicationController
    before_action :tweet_params, only: [:tweet_favs_index, :create_fav, :unfav]
    #before_action :user_id, only: [:create_fav, :unfav]
    before_action :get_user_favs, only: :user_favs_index
    
    def user_favs_index
        #json_response(get_user_favs)
        tweet_ids = @user_fav.map do |show_tweets_favs|
            show_tweets_favs.tweet_id
        end
        tweet_show = Tweet.where(id: tweet_ids)
        json_response(tweet_show)
    end

    def tweet_favs_index
        json_response(@tweet_fav)
    end

    def create_fav
        #binding.pry
        fav = @current_user.favs.create(user_id: @current_user.id, tweet_id: @tweet_id)
        json_response(fav, :created)        
    end

    def unfav
        @current_user.favs.find_by(user_id: @current_user.id, tweet_id: @tweet_id).destroy
        head :no_content
    end

    private

    def get_user_favs
        @user_fav = if @current_user.username == params[:username]
            @current_user.favs
        else
            @current_user.followings.find_by!(username: params[:username]).favs
        end
        #@follow = @current_user.follows.find_by!(id: params[:id]) if @current_user
    end


    def tweet_params
        @tweet_id = Tweet.find_by!(id: params[:tweet_id]).id
        @tweet_fav = Tweet.find_by!(id: params[:tweet_id]).favs
    end
end