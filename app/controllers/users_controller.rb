class UsersController < ApplicationController
  
  skip_before_filter :require_user, :only => [:create, :login, :verify_email]
  
  def index
    @users = User.valid.not_blocked(@current_user)
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :users => @users}.to_json(:include => :languages) }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email_token = SecureRandom.uuid
    
    session = Session.new(session_params)
    
    respond_to do |format|
      if @user.save && session.save
        format.html { 
          set_session_cookie session.auth_token
          redirect_to("/") 
        }
        
        format.json { render :json => { :success => true, :auth_token => session.auth_token } }
      else
        format.html { render :new }
        format.json { render :json => { :success => false, :errors => @user.errors } }
      end
    end
  end

  def show
    @user = User.valid.not_blocked(@current_user).find(params[:id])
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :user => @user.to_json(:include => :languages) } }
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    @current_user.deleted = true
    @current_user.save
  end
  
  def login
    @user = User.find_by(:email => params[:email])
    respond_to do |format|
      if @user && @user.authenticate(params[:password])
        session = Session.new(session_params)
        @user.sessions << session
        format.html { 
          set_session_cookie session.auth_token
          redirect_to("/") 
        }
        
        format.json { render :json => { :success => true, :auth_token => session.auth_token } }
      else
        format.html { }
        format.json { render :json => { :success => false, :errors => @user.errors } }
      end
    end
  end
  
  def logout
    @session.destroy
    respond_to do |format|
      format.html { 
        cookies.delete :auth_token
        redirect_to "/"
      }
      format.json { render :json => { :success => true } }
    end
  end
  
  def verify_email
    @user = User.find_by(:email_token => params[:token])
    respond_to do |format|
      if @user && @user.update_attributes(:email_token => nil, :verified => true)
        format.html { }
        format.json { render :json => { :success => true } }
      else
        format.html { }
        format.json { render :json => { :success => false } }
      end
    end
  end
  
  def set_session_cookie(auth_token)
    cookies.signed[:auth_token] = {
      :value => auth_token,
      :httponly => true
    }
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :account_type)
  end
  
  def session_params
    params.require(:session).permit(:device_type, :device_id, :push_token, :language)
  end

end
