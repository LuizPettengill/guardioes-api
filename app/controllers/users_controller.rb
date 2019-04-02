class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /user
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if current_user.id.to_s != params[:id].to_s
        render json: { errors: [
          detail: I18n.t("user.access_forbiden")
        ]}, status: :unprocessable_entity
      else
        @user = User.find(current_user.id)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:user_name, :email, :birthdate, :country, :gender, :race, :is_professional, :app_id)
    end
end