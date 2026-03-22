module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    def create
      user = User.find_by(email: sign_in_params[:email])

      unless user&.valid_password?(sign_in_params[:password])
        return render json: { errors: ['Invalid email or password'] }, status: :unauthorized
      end

      user.regenerate_auth_token

      render json: {
        user: {
          id: user.id,
          email: user.email
        },
        access_token: user.auth_token,
        token_type: 'Bearer'
      }, status: :ok
    end
  end
end