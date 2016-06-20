class SuggestionsController < ApplicationController
  
  def index
    @request = Request.valid.find(params[:request_id])
    @suggestions = @request.suggestions
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :suggestions => @suggestions.to_json } }
    end
  end
  
  def new
    @request = Request.valid.find(params[:request_id])
    @suggestion = Suggestion.new
  end
  
  def create
    @request = Request.valid.find(params[:request_id])
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.request = @request
    @suggestion.user = @current_user
    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to request_suggestion_path(@request, @suggestion) }
        format.json { render :json => { :success => true, :suggestion_id => @suggestion.id } }
      else
        format.html { render :new }
        format.json { render :json => { :success => false, :errors => @suggestion.errors } }
      end
    end
  end
  
  def show
    @request = Request.valid.find(params[:request_id])
    @suggestion = @request.suggestions.find(params[:id])
    respond_to do |format|
      format.html {  }
      format.json { render :json => { :suggestion => @suggestion } }
    end
  end
  
  def edit
    @request = @current_user.requests.valid.find(params[:request_id])
    @suggestion = @request.suggestions.find(params[:id])
  end
  
  def update
    @request = @current_user.requests.valid.find(params[:request_id])
    @suggestion = @request.suggestions.find(params[:id])
    respond_to do |format|
      if @suggestion.update_attributes(suggestion_params_update)
        format.html { redirect_to request_suggestion_path(@request, @suggestion) }
        format.json { render :json => { :suggestion => @suggestion } }
      else
        format.html { render :edit }
        format.json { render :json => { :suggestion => @suggestion } }
      end
    end
  end
  
  private
  def suggestion_params
    params.require(:suggestion).permit(:text)
  end
  
  def suggestion_params_update
    params.require(:suggestion).permit(:succesful)
  end
  
end
