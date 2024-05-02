
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :api_request?

  private

  def api_request?
    request.format.json?
  end
end
