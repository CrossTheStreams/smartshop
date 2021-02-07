class ApplicationController < ActionController::Base

  before_action :set_db_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_db_user
    if current_user
      ActiveRecord::Base.connection.execute("SET role #{current_user.db_user}")
    else
      ActiveRecord::Base.connection.execute("SET role postgres")
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email)
    end
  end

end
