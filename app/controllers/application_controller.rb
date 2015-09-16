class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # We must tell Devise that we have extra paramaters in the params hash.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :tone_name << :admin
  end

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end
end
