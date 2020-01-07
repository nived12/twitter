# spec/requests/follows_spec.rb
require 'rails_helper'

RSpec.describe 'Follows API' do
    # Initialize the test data
    let!(:user) { create(:user, username: "nived") }
    let!(:users) { create_list(:user, 4) }
    let!(:username) { user.username }
    let!(:user_id) {user.id}

    let!(:following1) { create(:follow, user_id: user.id, following_id: 4) }
    let!(:following2) { create(:follow, user_id: user.id, following_id: 3) }
    let!(:following3) { create(:follow, user_id: user.id, following_id: 5) }
    let!(:following4) { create(:follow, user_id: user.id, following_id: 2) }
    let!(:following_new) { create(:user, username: "pedro") }
    let!(:following5) { create(:follow, user_id: user.id, following_id: following_new.id) }

    let!(:follower1) { create(:follow, user_id: 2, following_id: user.id) }
    let!(:follower2) { create(:follow, user_id: 3, following_id: user.id) }
    let!(:follower3) { create(:follow, user_id: 4, following_id: user.id) }
    let!(:follower4) { create(:follow, user_id: 5, following_id: user.id) }
    let!(:follower5) { create(:follow, user_id: following_new.id, following_id: user.id) }

    # authorize request
    let(:headers) { valid_headers }

    # def followings_index
    #     json_response(@current_user.followings)
    # end
    # Test suite for GET /#{username}/followings
    describe 'GET /:username/followings' do

        context 'when user exists' do
            before { get "/#{username}/followings", params: {}, headers: headers }
            it 'returns status code 200' do
                #binding.pry
                expect(response).to have_http_status(200)
            end

            it 'returns all user followings' do
                expect(json.size).to eq(5)
            end
        end

        context 'when user does not exist' do
            before { get "/devin/followings", params: {}, headers: headers }

            it 'returns status code 404' do
                #binding.pry
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    # def followers_index
    #     json_response(@current_user.followers)
    # end
    # Test suite for GET /#{username}/followres
    describe 'GET /:username/followers' do
        before { get "/#{username}/followers", params: {}, headers: headers }

        context 'when user exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all user followings' do
                expect(json.size).to eq(5)
            end
        end

        context 'when user does not exist' do
            before { get "/devin/followers", params: {}, headers: headers }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    # def create_follow
    #     follower = @current_user.follows.create(user_id: @current_user.id, following_id: @follower_id)
    #     json_response(follower, :created)        
    # end
    # Test suite for POST /#{username}
    describe 'POST /:username:' do
        context 'when request attributes are valid' do
            let(:username) {following_new.username}
            before { post "/#{username}", params: {}, headers: headers }

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when user does not exist' do
            before { post "/devin", params: {}, headers: headers }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    # Test suite for DELETE /users/:id
    describe 'DELETE /:username' do
        context 'when follows exist' do
            let(:username) {following_new.username}
            before { delete "/#{username}", params: {}, headers: headers }
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when follows does not exist' do
            let(:username) {'juan'}
            before { delete "/#{username}", params: {}, headers: headers }
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end
end