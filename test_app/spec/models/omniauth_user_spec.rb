require 'spec_helper'

describe OmniauthUser do
  fixtures :users, :authentications
  it "should return user if they already have an account" do
    test_user = User.find(1)
    auth = get_auth(test_user.email)
    OmniauthUser.find_or_create(auth).should eq test_user
  end
  
  it "should create a user if there is no account associated with email address" do
    auth = get_auth("test2@test.com")
    OmniauthUser.find_or_create(auth).should eq User.all.last
  end
  
  it "should return nil if user is authenticating from a different service w/ an existing email" do
    test_user = User.find(1)
    auth = get_auth(test_user.email,"test2")
    OmniauthUser.find_or_create(auth).should eq nil
  end
end

def get_auth(email,provider="test",uid="123")
  auth = {"user_info"=>{"email"=>email}, "provider"=>provider, "uid"=>uid}
end
