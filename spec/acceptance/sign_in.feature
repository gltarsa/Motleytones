Feature: Sign-In

  Most users of the site do not need an account in order to make use of the
  site/app.  Band members and select others will need access to private
  features.

  * A user can sign into the app with registered email and password

  Background:
    Given I am not signed in

  @javascript
  Scenario: A user can sign into the system with registered email and password
    When I navigate to the Sign In page
    And I enter a registered email
    And I enter the associated password
    And I click Sign In
    Then I am sent to the Profile page
    And I see the new user name
    And I see a success message containing "Signed in successfully"

  @javascript
  Scenario: A user cannot sign into the system with an unregistered email or password
    When I navigate to the Sign In page
    And I enter an unregistered email
    And I enter an invalid password
    And I click Sign In
    Then I see an alert containing "Invalid Email or password"
    When I enter a registered email
    And I enter an invalid password
    And I click Sign In
    Then I see an alert containing "Invalid Email or password"
