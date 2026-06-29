module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

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
