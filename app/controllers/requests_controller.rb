class RequestsController < ApplicationController
  
  def index
    @requests = Request.valid
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :requests => @requests.to_json } }
    end
  end
  
  def new
    @request = Request.new
  end
  
  def create
    @request = Request.new(request_params)
    @request.user = @current_user
    respond_to do |format|
      if @request.save
        format.html { redirect_to request_path(@request) }
        format.json { render :json => { :success => true, :request_id => @request.id } }
      else
        format.html { render :new }
        format.json { render :json => { :success => false, :errors => @request.errors } }
      end
    end
  end
  
  def show
    @request = Request.valid.find(params[:id])
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :request => @request.to_json(:include => :languages) } }
    end
  end
  
  def edit
    @request = @current_user.requests.valid.find(params[:id])
  end
  
  def update
    @request = @current_user.requests.valid.find(params[:id])
    respond_to do |format|
      if @request.update_attributes(request_params)
        format.html { redirect_to request_path(@request) }
        format.json { render :json => { :success => true } }
      else
        format.html { render :edit }
        format.json { render :json => { :success => false, :errors => @request.errors } }
      end
    end
  end
  
  def destroy
    @request = @current_user.requests.valid.find(params[:id])
    @request.update_attributes(:deleted => true)
    respond_to do |format|
      format.html { redirect_to request_path(@request) }
      format.json { render :json => { :success => true } }
    end
  end
  
  private
  def request_params
    params.require(:request).permit(:category, :name, :award, :privacy, :description, 
      :last_date, :extra_request)
  end
  
end
