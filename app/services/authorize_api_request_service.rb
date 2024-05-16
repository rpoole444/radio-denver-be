class AuthorizeApiRequestService
  def initialize(headers = {})
    @headers = headers
  end

  def result
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise(
      RuntimeError,
      ("Invalid token: #{e.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebTokenService.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise RuntimeError, 'Missing token' unless headers['Authorization'].present?
  end
end
