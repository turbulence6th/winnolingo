class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :null_session
  
  before_action :current_user
  before_action :require_user
  before_action :set_i18n_locale_from_params
  
  def current_user
    @session = Session.find_by(:auth_token => cookies[:auth_token] ? cookies[:auth_token] : params[:auth_token])
    @current_user = @session.user if @session
  end
  
  def require_user
    if !@current_user
      respond_to do |format|
        format.html { redirect_to("/") }
        format.json { render :json => { :require_session => true }, :status => 401 }
      end
      return
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
  
  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  
  def default_url_options
    {
      :locale => I18n.locale
    }
  end
  
  def top_ten_requests
    Request.joins(:suggestions).group(:id).order("COUNT(requests.id) DESC").limit(10)
  end
  
  def most_successful_members(page, language_ids)
    User.joins(:userLanguages).where(:user_languages => { :language_id => language_ids})
      .order(:winno_point => :desc).paginate(:page => page, :per_page => 10)
  end
  
  def actual_requests(page, language_ids)
    Request.joins(:languageRequests).where(:language_requests => { :language_id => language_ids })
      .order(:created_at => :desc).paginate(:page => page, :per_page => 10)
  end
end
