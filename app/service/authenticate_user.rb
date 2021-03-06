class AuthenticateUser
  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def self.call(email, password)
    new(email, password).generate_user_token
  end

  def generate_user_token
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  # assign and authenticate user or raise error.
  def user
    @user ||= User.find_by(email: email)
    return @user if @user&.authenticate(password)

    raise GraphQL::ExecutionError, Message.invalid_credentials
  end
end
