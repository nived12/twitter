Rails.application.routes.draw do
  # resources :users, except: [:create, :show] do
  #   resources :tweets, only: [:index, :show, :destroy]
  # end
  resources :users, only: [:index]

  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'compose/tweet', to: 'tweets#create'
  get "/:username", to: 'tweets#index'
  delete "/:username/tweets/:tweet_id", to: 'tweets#destroy'
  get "/:username/tweets/:tweet_id", to: 'tweets#show'
  get '/:username/followings', to: 'follows#followings_index'
  get '/:username/followers', to: 'follows#followers_index'
  post '/:username', to: 'follows#create_follow'
  delete '/:username', to: 'follows#unfollow'
  get '/:username/likes', to: 'favs#user_favs_index'
  get '/:username/tweets/:tweet_id/likes', to: 'favs#tweet_favs_index'
  post '/:username/tweets/:tweet_id', to: 'favs#create_fav'
  delete '/:username/tweets/:tweet_id', to: 'favs#unfav'

  root 'homes#index'

end
