class ApplicationController < ActionController::Base
  before_action :authorize
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
end
