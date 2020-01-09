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

    # def show
    #     user = User.find_by(username_show_params)
    #     render json: user, status: :ok, serializer: CompleteUserSerializer
    # end

    def update                 
        user = User.find_by(username: @current_user.username)
        user.update!(username_edit_params)
        response = { message: Message.account_edited, status: :ok}
        json_response(response)
    end

    def destroy
        User.find_by(username: @current_user.username).destroy
        head :no_content
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

    def username_edit_params
        params.permit(:username)
    end
end
