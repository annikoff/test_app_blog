# frozen_string_literal: true
module AuthHelper
  def http_authorization(user)
    credentials = ActionController::HttpAuthentication::Basic
                  .encode_credentials(user.email, user.password)
    { 'HTTP_AUTHORIZATION' => credentials }
  end
end
