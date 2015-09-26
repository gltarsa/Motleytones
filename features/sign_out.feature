Feature: Sign-Out
  A signed-in user must be able to sign out, destroying his session

  @javascript
  Scenario: A user who is signed into the app can sign out
    Given I am signed in as a non-admin user
    When I navigate to the Sign Out link
    Then I see a success message containing "Signed out successfully"
