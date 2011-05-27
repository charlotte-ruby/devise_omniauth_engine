Feature: Devise with Omniauth
  In order to use devise w/ omniauth
  A user should be able to
  login using various providers

  @selenium
  Scenario: A user can login with twitter
    Given I am on the "twitter" auth page
    And I fill in "username_or_email" with "RailsTestAcct"
    And I fill in "password" with "thisisatest"
    And I press "Sign In"
    Then  I should see "Successfully authorized from Twitter account."
    And there is a user "RailsTestAcct"
    And "RailsTestAcct"'s profile "name" is "Test Account"
    And "RailsTestAcct"'s profile "nickname" is "RailsTestAcct"
    And "RailsTestAcct"'s profile "image" is "http://a0.twimg.com/sticky/default_profile_images/default_profile_1_normal.png"
    And "RailsTestAcct" has profile urls for "Twitter"
    And there is a "twitter" authentication associated with "RailsTestAcct"
    
  @selenium  
  Scenario: A user can login with Facebook
    Given I am on the "facebook" auth page
    And I fill in "email" with "testacctforrailsdev@gmail.com"
    And I fill in "pass" with "thisisatest"
    And I press "Log In"
    And I should see "Successfully authorized from Facebook account."
    And there is a user "testacctforrailsdev@gmail.com"
    And "testacctforrailsdev@gmail.com"'s profile "email" is "testacctforrailsdev@gmail.com"
    And "testacctforrailsdev@gmail.com"'s profile "first_name" is "BillyBob"
    And "testacctforrailsdev@gmail.com"'s profile "last_name" is "Tester"
    And "testacctforrailsdev@gmail.com"'s profile "name" is "BillyBob Tester"
    And "testacctforrailsdev@gmail.com"'s profile "image" is "http://graph.facebook.com/100002403724401/picture?type=square"
    And there is a "facebook" authentication associated with "testacctforrailsdev@gmail.com"

  @selenium
  Scenario: A user can login with Google apps
    Given I am on the "google_apps" auth page
    And I fill in "Email" with "testacctforrailsdev"
    And I fill in "Passwd" with "thisisatest"
    And I press "Sign in"
    Then I should see "Successfully authorized from Google Apps account."
    And there is a user "testacctforrailsdev@gmail.com"
    And there is a "google_apps" authentication associated with "testacctforrailsdev@gmail.com"    
    
  @selenium  
  Scenario: A user can login with Yahoo  
    Given I am on the "open_id?openid_url=yahoo.com" auth page    
    And I fill in "username" with "mistertester55@yahoo.com"
    And I fill in "passwd" with "thisisatest"
    And I press "Sign In"
    Then I should see "Successfully authorized from me.yahoo.com account."
    And there is a user "mistertester55@yahoo.com"
    
  @selenium  
  Scenario: A user can't login using an external account with the same email
    Given I am on the "google_apps" auth page
    Then I should see "Successfully authorized from Google Apps account."
    And I am on the logout page
    Given I am on the "facebook" auth page
    Then I should see "There is another account associated with this email. Please login with your existing account."
    
  Scenario: Twitter, FB, Google & Yahoo links show up on sign in page
    Given I am on the sign in page
    Then I should see "Sign in with Twitter"
    And I should see "Sign in with Facebook"
    And I should see "Sign in with Google"
    And I should see "Sign in with Yahoo"        