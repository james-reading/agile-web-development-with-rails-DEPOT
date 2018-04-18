class ApplicationController < ActionController::Base
  before_action :authorize, :set_i18n_locale_from_params
  protect_from_forgery with: :exception

  protected

    def authorize
      if User.count.zero?
        if !(request.path_parameters[:controller] == 'users' and
            (request.path_parameters[:action] == 'new' or request.path_parameters[:action] == 'create'))
          flash[:notice] = "Please create Admin User"
          redirect_to controller: 'users', action: 'new'
        end
      elsif !User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
