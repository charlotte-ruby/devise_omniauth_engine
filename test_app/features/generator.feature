Feature: generating devise_omniauth_engine files
  In order to use devise_omniauth_engine
  A user should be able to
  generate files for devise_omniauth_engine

  Scenario: run install generator
    Given a working directory
    And I cleanup
    When I run the install generator
    Then a timestamped file named 'create_authentications_table.rb' is created in the '/db/migrate/' directory
    And a timestamped file named 'devise_create_users.rb' is created in the '/db/migrate/' directory    
    And a file named "devise_omniauth_engine.yml" is created in the "/config/yettings/" directory
    And a file named "_links.erb" is created in the "/app/views/devise/shared/" directory
    And a file named "devise.rb" is created in the "/config/initializers/" directory
    And a file named "devise.en.yml" is created in the "/config/locales/" directory
    And a file named "index.html.erb" is created in the "/app/views/users/" directory
    And a file named "users_controller.rb" is created in the "/app/controllers/" directory    
    And the file "app/models/user.rb" contains "has_many :authentications"
    And the file "config/routes.rb" contains "devise_for :users, :controllers => { :omniauth_callbacks => "
            