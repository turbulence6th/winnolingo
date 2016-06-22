class BlocksController < ApplicationController
  
  def index
    @blocks = @current_user.blockeds.public_params
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :blocks => @blocks }.to_json }
    end
  end
  
  def create
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @current_user.blockeds << @user
        format.html { redirect_to(blocks_path) }
        format.json { render :json => { :success => true } }
      else
        format.html { redirect_to(blocks_path) }
        format.json { render :json => { :success => false } }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @current_user.blockeds.delete(@user)
        format.html { redirect_to(blocks_path) }
        format.json { render :json => { :success => true } }
      else
        format.html { redirect_to(blocks_path) }
        format.json { render :json => { :success => false } }
      end
    end
  end
  
end
