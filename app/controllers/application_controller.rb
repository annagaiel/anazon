class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    unless current_user && current_user.admin
      redirect_to '/'
    end
  end

  def signed_in
    unless current_user
      redirect_to '/users/sign_in'
    end
  end
end
