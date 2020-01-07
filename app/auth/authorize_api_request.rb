class AuthorizeApiRequest
  
  #Inicializa el metodo con el token del usuario
  def initialize(headers = {})
    @headers = headers
  end

  # Hace el llamado al metodo user para recibir el usuario correspondiente
  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  #Busca el usuario correspondiente al token que se solicito como header
  def user
    # check if user is in the database
    # memorize user object
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  # Con el header (En este caso es el token), decodifica con la clase JsonWebToken.decode
  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  #Primero checa si se encuentra presente un token. Si se encuentra un token, 
  #regresa el ultimo valor del string (el ultimo string despues de un espacio) como un array del string.
  # check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last #Preguntar por qué last, si el token es un string sin espacios y se llama con .split(' ')
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end