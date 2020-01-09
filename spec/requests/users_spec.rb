require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  #Del controller_spec_helper.rb obtiene valid_headers
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    #Para que no cree otra contraseña diferente
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Username can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe 'PUT /settings/screen_name' do
    let(:user) {create(:user)}
    let(:headers1) { valid_headers }
    context 'when valid request' do
      # # let(:username) {user.to_json(:only => [:username])}
      # let(:username) {(user.username).to_json}
      let(:valid_attributes2) {{ username: 'pedro' }.to_json}
      before {put '/settings/screen_name', params: valid_attributes2, headers: headers1}
      
      it 'edit current username' do
        expect(response).to have_http_status(200)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account edited successfuly/)
      end
    end

    context 'when invalid request' do
      before { put '/settings/screen_name', params: {}, headers: headers1 }

      it 'does not edit current username' do
        expect(response).to have_http_status(200)
      end
    end
  end
  
  # Test suite for DELETE /delete
  describe 'DELETE /delete' do
    let(:user) {create(:user)}
    let(:headers1) { valid_headers }
    before { delete "/delete", params: {}, headers: headers1 }

    it 'returns status code 204' do
        expect(response).to have_http_status(204)
    end
  end
end