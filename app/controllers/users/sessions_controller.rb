# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # lookup_user = LookupUser.where(:email => warden_conditions[:email]).first
    # user_schema = lookup_user.schema_name
    # Smartshop::MultiTenancy.with_schema(user_schema) d
    self.resource = warden.authenticate!(auth_options)
    session[:schema] = resource.schema_name
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    # Flush the session schema
    session[:schema] = nil
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:e])
  end
end
