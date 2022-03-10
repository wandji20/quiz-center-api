class AuthorizeApiRequest
  attr_accessor :decoded_auth_token, :user
  attr_reader :headers

  class << self
    def call(headers = {})
      @headers = headers
      {
        user: user
      }
    end


    def user
      @user ||= User.find(decoded_auth_token[:user_id])
    rescue ActiveRecord::RecordNotFound
      raise ExceptionHandler::InvalidToken, Message.invalid_token
    end

    def http_header_token
      return headers[:Authorization].split.last if headers[:Authorization]&.present?

      raise ExceptionHandler::MissingToken Message.missing_token
    end

    def decoded_auth_token
      @decoded_auth_token ||= JWT.decode(http_header_token)
    end
  end
end