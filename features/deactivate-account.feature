 Feature: Deactivate Account
   Registered users should be able to deactivate their accounts.
   * A registered user can deactivate his own account from his profile page.
   * An admin user can deactivate anyone's account from the User List page

   @javascript
   Scenario: A non-admin user can deactivate his own profile
     Given I am signed in as a non-admin user
     When I navigate to the Profile page
     When I click Deactivate and confirm deactivation for that user
     Then that user is deactivated


