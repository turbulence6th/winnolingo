class RequestsController < ApplicationController
  
  def index
    @user = User.find(user_id)
    @requests = @user.requests
  end
  
  def new
    @request = Request.new
  end
  
  def create
    @request = Request.new(request_params)
    @request.user = @current_user
    
    respond_to do |format|
      if @request.save
        format.html { redirect_to url_for(@request) }
        format.json { render :json => { :success => true, :request_id => @request.id } }
      else
        format.html { render :new }
        format.json { render :json => { :success => false, :errors => @request.errors } }
      end
    end
  end
  
  def show
    
  end
  
  private
  def request_params
    params.require(:request).permit(:category, :name, :award, :privacy, :description, 
      :last_date, :extra_request)
  end
  
end
