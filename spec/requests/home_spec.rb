# spec/requests/tweets_spec.rb
require 'rails_helper'

RSpec.describe 'Home API' do

    # Test suite for GET /
    describe 'GET /' do
        context 'when tweets exists' do
            # Initialize the test data
            let!(:user) { create(:user, username: 'nived')}
            let!(:users) { create_list(:user, 2) }
            let!(:follow1) {create(:follow, user_id: user.id, following_id: users.first.id)}
            let!(:tweets) { create_list(:tweet, 6, user_id: user.id) }
            let!(:tweets1) { create_list(:tweet, 5, user_id: users.first.id) }
            let!(:tweets2) { create_list(:tweet, 4, user_id: users.second.id) }
            # authorize request
            let(:headers) { valid_headers }

            before { get "/", params: {}, headers: headers }

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all users tweets' do
                expect(json.size).to eq(11)
            end
        end

        context 'when there is not tweets' do
            let!(:user) { create(:user, username: 'nived')}
            let!(:users) { create_list(:user, 2) }
            let!(:follow1) {create(:follow, user_id: user.id, following_id: users.first.id)}
            let(:headers) { valid_headers }
            before { get "/", params: {}, headers: headers }

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all users tweets' do
                expect(json.size).to eq(0)
            end
        end
    end
end