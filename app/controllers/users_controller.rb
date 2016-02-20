class UsersController < ApplicationController
  def index

  end

  def new

  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json {
          render :json => {
            :success => true
          }
        }
      else
        format.json {
          render :json => {
            :success => false,
            :errors => @user.errors
          }
        }
      end
    end
  end

  def show

  end

  def user_params
    params.require(:user).permit(:name, :surname, :email, :username,
    :password, :password_confirmation)
  end

end
