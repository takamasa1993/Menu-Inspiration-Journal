class ApplicationController < ActionController::Base
  
   protect_from_forgery with: :exception

  helper_method :admin_signed_in?, :current_admin
  
  
  private

  def admin_signed_in?
    !current_admin.nil?
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
  
end
