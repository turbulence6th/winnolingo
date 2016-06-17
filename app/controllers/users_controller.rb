class UsersController < ApplicationController
  def index

  end

  def new

  end

  def create
    @user = User.new(user_params)
    @user.email_token = SecureRandom.uuid
    if @user.save
      redirect_to "/"
    else
      render :new
    end
  end

  def show

  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :account_type)
  end

end
