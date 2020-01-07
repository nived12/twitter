class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
    
    #Es solamente para uso personal (ver los usuarios creados)
    def index
        json_response(User.all)    
    end

    # POST /signup
    # return authenticated token upon signup
    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.username, user.password).call
        response = { message: Message.account_created, auth_token: auth_token }
        json_response(response, :created)
    end

    private

    def user_params
        params.permit(
        :username,
        :email,
        :password,
        :password_confirmation
        )
    end
end
