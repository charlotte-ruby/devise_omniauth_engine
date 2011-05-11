require "devise_omniauth_engine"
require "rails"

module DeviseOmniauthEngine
  class Engine < Rails::Engine
    initializer "devise.omniauth.config", :before=>:engines_blank_point do
      Devise.setup do |config|
        require 'openid/store/filesystem'
        begin
          config.omniauth :twitter, DeviseOmniauthEngineYetting.twitter_key, DeviseOmniauthEngineYetting.twitter_secret
          config.omniauth :facebook, DeviseOmniauthEngineYetting.facebook_key, DeviseOmniauthEngineYetting.facebook_secret
          config.omniauth :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
          config.omniauth :open_id, OpenID::Store::Filesystem.new('/tmp')
        rescue 
        end
      end
    end
  end
end