class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize

  private

  def authorize
    authenticate_or_request_with_http_token do |token, _options|
      token == DealersApi::Application.config.api_token
    end
  end
end
