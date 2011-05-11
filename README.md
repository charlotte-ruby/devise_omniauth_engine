# devise_omniauth_engine

# THIS IS STILL A WIP, SO IT IS NOT READY FOR PRIME TIME!  USE AT YOUR OWN RISK!  THIS WILL BE CONSIDERED STABLE WHEN MOVED TO VERSION 0.1.0

This is meant for blank Rails 3 apps as an automated setup for Devise & Omniauth.  This engine will install devise and omniauth into your app and provide you with a callback controller that handles Twitter, Facebook, Google and Yahoo.  When you run the generator it performs the following steps for you:

1. rails generate devise:install
2. rails generate User
3. rails generate devise:views
4. Adds :omniauthable to the user model
5. Creates an Authentication model with provider, uid, and user_id.  For example, Bob authenticates using twitter, it would add Bob's user_id, provider=twitter, and uid=uid provided by twitter
6. Adds "has_many :authentications" to User model
7. Overwrites the default Devise view in app/views/devise/shared/links, so it includes Google, Yahoo, Facebook & Twitter
8. Creates UsersController and index view.  This is used as the default action after authentication.
9. Provides a YAML config file where you can enter your Twitter and Facebook API key/secret that will be used by Omniauth.  Directory = config/yettings/devise_omniauth_engine.yml

## Install

Add it to your Gemfile (This will include devise and omniauth gems, so no need to add them)

    gem "devise_omniauth_engine", :git=>"git@github.com:charlotte-ruby/devise_omniauth_engine.git"
    
Install it using Bundler
   
    bundle install
    
Run the generator

    rails g devise_omniauth_engine:install
    
There are a few things that the devise generators will tell you to do regarding flash, mailer, and your root route.  You will need to do these manually after the generator finishes.

Run migrations (devise and authentications model)

    rake db:migrate
    
By default, dev and test have working app keys for twitter and facebook apps.  These are just test apps, so you will want to add your own app keys/secrets to the config file - config/yettings/devise_omniauth_engine.yml

    defaults: &defaults
      twitter_key: <yours here>
      twitter_secret: <yours here>
      facebook_key: <yours here>
      facebook_secret: <yours here>
        

After that you can customize the views.  You can add buttons for Twitter, etc in this view:

    app/views/devise/shared/_links.html.erb
    
<b>NOTE:</b> If you are using Webrick as your development or test server, it will not be able to handle the size of the packets sent back by Yahoo and Google.  You should use mongrel instead:

    #Gemfile
    gem "mongrel", "1.2.0.pre2"
    
Install w/ bundler

    bundle install
    
Start up your mongrel in dev

    rails s


## TODO
1. Allow users to associate multiple external providers to one account.  You are restricted to one per account currently.  
2. Add all omniauth providers to the Devise.setup block.  Callbacks controller method_missing may need to be updated to accommodate some of these

## Contributing to devise_omniauth_engine
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* NOTE: YOU WILL NEED TO UPDATE THE USERNAMES/PASSWORDS FOR THE AUTH FEATURE WITH YOUR OWN CREDENTIALS OR IT WILL FAIL
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 John McAliley. See LICENSE.txt for
further details.

