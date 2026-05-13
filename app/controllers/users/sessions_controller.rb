# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    def create
      result = Users::Session.call(
        email: sign_in_params[:email],
        password: sign_in_params[:password]
      )

      return render json: { error: result[:error] }, status: :unauthorized unless result[:success]

      render json: {
        user: {
          id: result[:user].id,
          email: result[:user].email
        },
        access_token: result[:access_token].token,
        token_type: 'Bearer',
        expires_in: result[:access_token].expires_in,
        refresh_token: result[:access_token].refresh_token
      }, status: :ok
    end
  end
end
