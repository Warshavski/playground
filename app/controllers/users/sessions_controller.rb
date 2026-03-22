# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    def create
      user = User.find_by(email: sign_in_params[:email])

      unless user&.valid_password?(sign_in_params[:password])
        return render json: { errors: ['Invalid email or password'] }, status: :unauthorized
      end

      oauth_application = Doorkeeper::Application.find_by!(name: 'Books API')

      access_token = Doorkeeper::AccessToken.create!(
        application_id: oauth_application.id,
        resource_owner_id: user.id,
        scopes: '',
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        use_refresh_token: true
      )

      render json: {
        user: {
          id: user.id,
          email: user.email
        },
        access_token: access_token.token,
        token_type: 'Bearer',
        expires_in: access_token.expires_in,
        refresh_token: access_token.refresh_token
      }, status: :ok
    end
  end
end
