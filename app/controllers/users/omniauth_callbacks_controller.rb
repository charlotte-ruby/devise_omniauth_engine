require 'uri'
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing(provider)
    kind = provider==:open_id ? URI.parse(env["omniauth.auth"]['uid']).host : provider.to_s.titleize
    @user = OmniauthUser.find_or_create( env["omniauth.auth"] )
    if @user.blank?
      flash[:alert] = "There is another account associated with this email.  Please login with your existing account."
      redirect_to new_user_registration_url
    else
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.#{provider.to_s}_data"] = env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
end