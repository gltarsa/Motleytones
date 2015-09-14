Feature: Account deactivation
  Registered users should be able to deactivate their accounts.
  * A registered user can deactivate his own account from his profile page.
  * An admin user can deactivate anyone's account from the User List page

  @javascript
  Scenario: A non-admin user can deactivate his own profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click the Deactivate button for that user
    Then I am asked "Are you Sure?"
    When I click Yes
    Then I am logged out
    And I am sent to the root page


