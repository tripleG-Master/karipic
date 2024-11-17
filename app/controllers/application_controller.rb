class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_admin

    if current_user.nil?
      redirect_to root_path, alert: 'You must be signed in to access this page.'
    elsif !current_user.admin?  
      redirect_to root_path, alert: 'You dont have permission to access this page.'
    end
  end

end
