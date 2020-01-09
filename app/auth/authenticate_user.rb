class AuthenticateUser
  #Con attr_reader, podemos usar las variables @username y @password en cualquier metodo
  def initialize(username, password)
      @username = username
      @password = password
  end
    
  # Service entry point
  def call
    #Crea un token por medio de encode si se llega a comprobar que hay un usuario con el metodo de user
    JsonWebToken.encode(user_id: user.id) if user
  end

  private
  #Se encuentra en private, para que solamente se pueda usar dentro de la clase AuthenticateUser
  #Con attr_reader podemos obtener las variables fuera de su clase como variables de instancia
  attr_reader :username, :password

  # verify user credentials
  def user
    #Busca el usuario por su username
    user = User.find_by(username: username)
    #Si se encuentra el usuario con su contraseña, permite realizar el metodo call y asi regresar un token
    #authenticate evalua el password que se obtiene en initialize y has_secure_password dentro del modelo User
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end