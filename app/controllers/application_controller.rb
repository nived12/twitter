class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user

    private
    # Obtiene el usuario actual al crear un request en AuthorizeApiRequest
    # Check for valid request token and return user
    
    # No se porque esta en private si despues se hace un getter con attr_reader :current_user
    # Manda como header el token del usuario solicitado para poder decodificar
    def authorize_request
        @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user] 
    end
end
