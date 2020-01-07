# spec/requests/tweets_spec.rb
require 'rails_helper'

RSpec.describe 'Tweets API' do
    # Initialize the test data
    let!(:user) { create(:user) }
    let!(:tweets) { create_list(:tweet, 20, user_id: user.id) }
    let(:username) { user.username }
    let(:user_id) { user.id }
    let(:tweet_id) { tweets.first.id }
    # authorize request
    let(:headers) { valid_headers }

    # Test suite for GET /users/:user_id/tweets
    describe 'GET /:username' do
        before { get "/#{username}", params: {}, headers: headers }

        context 'when user exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all user tweets' do
                expect(json.size).to eq(20)
            end
        end

        context 'when user does not exist' do
            let(:username) { 'pedro' }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end

    # Test suite for GET /users/:user_id/tweets/:id
    describe 'GET /:username/tweets/:tweet_id' do
        before { get "/#{username}/tweets/#{tweet_id}", params: {}, headers: headers }

        context 'when user tweet exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the tweet' do
                expect(json['id']).to eq(tweet_id)
            end
        end

        context 'when user tweet does not exist' do
            let(:tweet_id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tweet/)
            end
        end
    end

    # Test suite for POST /compose/tweet
    describe 'POST /compose/tweet' do
        let(:valid_attributes) { { description: 'Lionel Messi' }.to_json }

        context 'when request attributes are valid' do
            before do
                post "/compose/tweet", params: valid_attributes, headers: headers
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when an invalid request' do
            before { post "/compose/tweet", params: {}, headers: headers }

            it 'returns status code 406' do
                expect(response).to have_http_status(406)
            end

            it 'returns a failure message' do
                expect(response.body).to match('Tweet not created.')
            end
        end
    end

    # Test suite for DELETE /users/:id
    describe 'DELETE /:username/tweets/:tweet_id' do
        before { delete "/#{username}/tweets/#{tweet_id}", params: {}, headers: headers }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end