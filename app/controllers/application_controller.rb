# frozen_string_literal: true

# ApplicationController
#
#   Used as base controller
#
class ApplicationController < ActionController::API
  include Handlers::Response
  include Handlers::Exception

  before_action :destroy_session!, :ensure_request_format!

  attr_reader :current_user

  private

  def destroy_session!
    request.session_options[:skip] = true
  end

  def ensure_request_format!
    return if request.format.json?

    message = I18n.t(:'errors.messages.routes.not_found')
    render_error([{ status: 404, detail: message }], :not_found)
  end

  def authenticate_user!
    @current_user = User.find_by(auth_token: bearer_token)

    return if @current_user.present?

    render json: { errors: ['Unauthorized'] }, status: :unauthorized
  end

  def user_signed_in?
    current_user.present?
  end

  def bearer_token
    authorization_header = request.headers['Authorization'].to_s
    authentication_scheme, token = authorization_header.split(' ', 2)

    return nil unless authentication_scheme == 'Bearer'

    token
  end
end