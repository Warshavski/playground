module Users
  class SessionsController < Devise::SessionsController
    def create
      user = User.find_by(email: sign_in_params[:email])

      if user&.valid_password?(sign_in_params[:password])

        render json: {
          user: {
            id: user.id,
            email: user.email
          }
        }, status: :ok
      else
        render json: {
          errors: ['Invalid email or password']
        }, status: :unauthorized
      end
    end
  end
end
