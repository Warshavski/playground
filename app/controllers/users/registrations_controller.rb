module Users
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, only: :create # временное решение

    def create
      result = Users::Registration.call(params: sign_up_params)

      if result[:success]
        render json: result[:user], serializer: UserSerializer, status: :created
      else
        render json: { errors: result[:error] }, status: :unprocessable_entity
      end
    end
  end
end
