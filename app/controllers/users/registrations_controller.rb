module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      build_resource(sign_up_params)

      if resource.save
        render json: {
          user: {
            id: resource.id,
            email: resource.email
          }
        }, status: :created
      else
        render json: {
          errors: resource.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  end
end
