class SuggestionsController < ApplicationController
  
  def index
    @user = User.find(user_id)
    @requests = @user.suggestions
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def show
    
  end
  
end
