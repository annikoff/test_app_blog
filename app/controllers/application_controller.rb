# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :authenticate

  private

  def authenticate
    @user = authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
      user if user&.authenticate(password)
    end
    request_http_basic_authentication unless @user
  end

  def render_error(status, errors = nil)
    render status: status, json: { errors: Array(errors) }
  end

  def render_validation_error(record)
    render_error 422, record.errors.full_messages
  end
end
