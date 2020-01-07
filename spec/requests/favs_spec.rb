# spec/requests/favs_spec.rb
require 'rails_helper'

RSpec.describe 'Favs API' do
    # Initialize the test data
    let!(:user) { create(:user, username: "nived") }
    let!(:tweets) { create_list(:tweet, 4, user_id: user.id) }
    let!(:users) { create_list(:user, 5) }
    let!(:username) { user.username }
    let!(:user_id) {user.id}
    let!(:tweet_id) { tweets.first.id }

    let!(:fav1) { create(:fav, user_id: user_id, tweet_id: 1) }
    let!(:fav2) { create(:fav, user_id: user_id, tweet_id: 2) }
    let!(:fav3) { create(:fav, user_id: user_id, tweet_id: 3) }
    let!(:fav4) { create(:fav, user_id: user_id, tweet_id: 4) }
    let!(:tweet_new) { create(:tweet, description: "Nuevo tweet", user_id:user.id) }
    let!(:fav5) { create(:fav, user_id: user.id, tweet_id: tweet_new.id) }

    let!(:tfav1) { create(:fav, user_id: 2, tweet_id: tweet_id) }
    let!(:tfav2) { create(:fav, user_id: 3, tweet_id: tweet_id) }
    let!(:tfav3) { create(:fav, user_id: 4, tweet_id: tweet_id) }
    let!(:tfav4) { create(:fav, user_id: 5, tweet_id: tweet_id) }
    let!(:tfav5) { create(:fav, user_id: 6, tweet_id: tweet_id) }

    let!(:tweet_u2) { create(:tweet, description: "Tweet usuario 2", user_id:2)}

    # authorize request
    let(:headers) { valid_headers }

    # def user_favs_index
    #     #json_response(get_user_favs)
    #     tweet_ids = @user_fav.map do |show_tweets_favs|
    #         show_tweets_favs.tweet_id
    #     end
    #     tweet_show = Tweet.where(id: tweet_ids)
    #     json_response(tweet_show)
    # end
    # Test suite for GET /#{username}/followings
    describe 'GET /:username/likes' do
        context 'when user exists' do
            before { get "/#{username}/likes", params: {}, headers: headers }
            it 'returns status code 200' do
                #binding.pry
                expect(response).to have_http_status(200)
            end

            it 'returns all user favs' do
                expect(json.size).to eq(5)
            end
        end

        context 'when user does not exist' do
            before { get "/devin/likes", params: {}, headers: headers }

            it 'returns status code 404' do
                #binding.pry
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    # def tweet_favs_index
    #     json_response(@tweet_fav)
    # end
    describe 'GET /:username/tweets/:tweet_id/likes' do
        before { get "/#{username}/tweets/#{tweet_id}/likes", params: {}, headers: headers }

        context 'when tweet exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all tweet favs' do
                expect(json.size).to eq(6)
            end
        end

        context 'when tweet does not exist' do
            before { get "/nived/tweets/100/likes", params: {}, headers: headers }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tweet/)
            end
        end
    end

    # def create_fav
    #     fav = @current_user.favs.create(user_id: @current_user.id, tweet_id: @tweet_id)
    #     json_response(fav, :created)        
    # end
    # Test suite for POST /#{username}
    describe 'POST /:username/tweets/:tweet_id' do
        context 'when request attributes are valid' do
            let(:tweet_id) {tweet_u2.id}
            let(:username) {users.first.username}

            before { post "/#{username}/tweets/#{tweet_id}", params: {}, headers: headers }

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when tweet does not exist' do
            let(:tweet_id2) {100}
            let(:username) {users.first.username}
            before { post "/#{username}/tweets/#{tweet_id2}", params: {}, headers: headers }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tweet/)
            end
        end
    end

    # Test suite for DELETE /:username/tweets/:tweet_id
    describe ':username/tweets/:tweet_id' do
        context 'when the fav exist' do
            let(:tweet_id) {3}
            before { delete "/#{username}/tweets/#{tweet_id}", params: {}, headers: headers }
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when fav does not exist' do
            context 'because user does not exist' do
                let(:username) {'pedro'}
                before { delete "/#{username}/tweets/#{tweet_id}", params: {}, headers: headers }
                it 'returns status code 404' do
                    expect(response).to have_http_status(404)
                end
                it 'returns a not found message' do
                    expect(response.body).to match(/Couldn't find User/)
                end
            end
            
            context 'because tweet does not exist' do
                let(:tweet_id3) {50}
                before { delete "/#{username}/tweets/#{tweet_id3}", params: {}, headers: headers }
                it 'returns status code 404' do
                    expect(response).to have_http_status(404)
                end
                it 'returns a not found message' do
                    expect(response.body).to match(/Couldn't find Tweet/)
                end
            end
        end
    end
end