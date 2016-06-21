class ApplicationController < ActionController::Base
  
  #protect_from_forgery with: :null_session
  
  before_action :current_user
  before_action :require_user
  before_action :set_locale
  
  def current_user
    @session = Session.find_by(:auth_token => cookies.signed[:auth_token] ? 
      cookies.signed[:auth_token] : params[:auth_token])
    @current_user = User.valid.find_by(:id => @session.user_id) if @session
  end
  
  def require_user
    if !@current_user
      respond_to do |format|
        format.html {
          cookies.delete :auth_token 
          redirect_to("/") 
        }
        format.json { render :json => { :require_session => true }, :status => 401 }
      end
      return
    end
  end
  
  def set_locale
    if @session && LANGUAGES.include?(@session.language)
      I18n.locale = @session.language
    end
  end
  
  def authenticate_admin_user!
    if !@current_user || @current_user.role!='admin'
      raise ActionController::RoutingError.new('Not Found')
    end
  end 
  
  def current_admin_user
    return nil if !@current_user || @current_user.role!='admin' 
    @current_user  
  end 
 
  def top_ten_requests
    Request.valid.joins(:suggestions).group(:id).order("COUNT(requests.id) DESC").limit(10)
  end
  
  def most_successful_members(page, language_ids)
    User.valid.joins(:userLanguages, :suggestions, :requests)
      .where(:user_languages => { :language_id => language_ids },
      :suggestions => { :successful => true }).group(:id)
      .order("COUNT(suggestions.id) + COUNT(requests.id) DESC")
      .paginate(:page => page, :per_page => 10)
  end
  
  def actual_requests(page, language_ids)
    Request.valid.joins(:languageRequests).where(:language_requests => { :language_id => language_ids })
      .order(:created_at => :desc).paginate(:page => page, :per_page => 10)
  end
end
