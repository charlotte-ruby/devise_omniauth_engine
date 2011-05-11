require 'rails/generators'
require 'rails/generators/migration'     

module DeviseOmniauthEngine
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.join(File.dirname(__FILE__), 'templates')
    argument :force, :type => :string, :default => "false"

    def self.next_migration_number(dirname)
      sleep 1
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

    def devise_omniauth_engine
      if force=="true" or yes?("This generator should only be used on new apps.  It will overwrite the routes file.  Do you want to continue?")
        generate("devise:install")
        generate("devise User")
        generate("devise:views")
        inject_into_file "app/models/user.rb", "  has_many :authentications\n\n", :after => "class User < ActiveRecord::Base\n"
        inject_into_file "app/models/user.rb", ", :omniauthable", :after => ":validatable"
        devise_for_users = "devise_for :users, :controllers => { :omniauth_callbacks => \"users/omniauth_callbacks\" } do\n    match 'user' => \"users#index\", :as => :user_root\n  end"
        gsub_file 'config/routes.rb', "devise_for :users", devise_for_users
        inject_into_file "config/routes.rb", "\nresources :authentications\n", :after=> "TestApp::Application.routes.draw do"
        migration_template 'db/migrate/create_authentications_table.rb', 'db/migrate/create_authentications_table.rb'
        copy_file "../../../../../config/yettings/devise_omniauth_engine.yml", "config/yettings/devise_omniauth_engine.yml"
        copy_file "../../../../../app/views/devise/shared/_links.erb", "app/views/devise/shared/_links.erb", :force=>true
        copy_file "../../../../../app/controllers/users_controller.rb", "app/controllers/users_controller.rb"
        empty_directory "app/views/users"
        copy_file "../../../../../app/views/users/index.html.erb", "app/views/users/index.html.erb"
      end
    end
  end
end