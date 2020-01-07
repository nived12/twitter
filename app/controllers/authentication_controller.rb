class AuthenticationController < ApplicationController
    #Realiza primero el authenticate antes de que se solicita el request de authorize_request
    skip_before_action :authorize_request, only: :authenticate
    
    # return auth token once user is authenticated
    def authenticate
        #Hace el llamado de la clase AuthenticaUser, manda los parametros de :username y :password
        #Realiza el metodo call para obtener el Token del user_id
        #Arroja el token como Json_response
        auth_token = AuthenticateUser.new(auth_params[:username], auth_params[:password]).call 
        json_response(auth_token: auth_token)
    end

    private

    def auth_params
        #Solamente permite los parametros :username y :password
        params.permit(:username, :password)
    end
end
