class ApplicationController < ActionController::Base

  around_action :using_current_user_schema
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def using_current_user_schema
    if session[:schema]
      Smartshop::MultiTenancy.with_schema(session[:schema]) do
        yield
      end
    else
      Smartshop::MultiTenancy.with_schema("public") do
        yield
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :remember_me, :password)
    end
  end

end
