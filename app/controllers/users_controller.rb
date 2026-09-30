class UsersController < ApplicationController
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def show
    result = Users::Show.call(id: params[:id])
    if result[:success]
      render json: result[:user], serializer: UserSerializer
    else
      render json: { errors: result[:error] }, status: :not_found
    end
  end

  def update
    result = Users::Update.call(id: params[:id], params: user_params)

    if result[:success]
      render json: result[:user], serializer: UserSerializer, status: :ok
    else
      render json: { errors: Array(result[:error]) }, status: result[:status] || :unprocessable_entity
    end
  end

  def destroy
    result = Users::Delete.call(id: params[:id])
    if result[:success]
      head :no_content
    else
      render json: { errors: result[:error] }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
