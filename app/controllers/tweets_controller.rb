class TweetsController < ApplicationController
    before_action :set_user_tweet, only: [:show, :destroy]
    before_action :get_user_tweets, only: [:index]

    # GET /:username
    def index
        render json: @tweet_user#, each_serializer: SimpleFavSerializer
    end

    # GET /users/:user_id/tweets/:id
    def show
        json_response(@tweet)
    end

    def create
        #Crea un tweet del usuario actual, permitiendo el parametro 
        #description del metodo tweet_params
        tweet = @current_user.tweets.create(tweet_params)
        if tweet.id.nil?
            json_response(Message.not_created('Tweet'), :not_acceptable)
            #binding.pry
        else   
            # binding.pry
            json_response(tweet, :created)
        end
    end

    # DELETE /users/:user_id/tweets/:id
    def destroy
        @tweet.destroy
        head :no_content
    end

    private

    def tweet_params
        params.permit(:description) 
    end

    def get_user_tweets
        @tweet_user = if @current_user.username == params[:username]
            @current_user.tweets
        else
            @current_user.followings.find_by!(username: params[:username]).tweets
        end
        #@follow = @current_user.follows.find_by!(id: params[:id]) if @current_user
    end

    def set_user_tweet
        #@tweet = @current_user.tweets.find_by!(id: params[:tweet_id]) if @current_user
        @tweet = if @current_user.username == params[:username]
            @current_user.tweets.find_by!(id: params[:tweet_id])
        else
            @current_user.followings.find_by!(username: params[:username]).tweets.find_by(id: params[:tweet_id])
        end
    # rescue ActiveRecord::RecordNotFound
    #     json_response({ message: Message.not_found('tweet') }, :not_found)
    end
end
