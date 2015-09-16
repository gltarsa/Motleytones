Feature: Admin User Management
  A user who has his admin flag set can perform certainother operations in the app.

  * An admin user can create user accounts.
  * An admin user can delete accounts from the Users List page, including
    changing the admin flag.
 # * An admin user can deactivate an account from the Users List page.

  Scenario: Admin users can create a new user account
    Given I am signed in as an admin user
    When I navigate to the Sign Up page
    Then I see the page title "Add New Pirate"
    And I see the appropriate fields
    And I see the password and password_confirmation fields
    When I fill in the fields
    And I click Sign up
    Then the account is created
    And I am still in the admin account

  Scenario:  Admin users can delete a user account
    Given I am signed in as an admin user
    And there is at least one other user
    When I visit the Users page
    And I see the window tile "Motley Users"
    And I see information for another user
    When I click the Delete button for that user
    Then I see an "Are you sure?" dialog box
    When I click Yes
    Then the user is deleted

  Scenario:  Admin users can edit a user account from the Users Page
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Users page
    And I see information for another user
    When I click the Edit button for that user
    Then I am sent to the Change User Information page
    When I change the mutable fields
    And I change the user_name field
    And I change the admin checkbox
    And I click Update
    Then the mutable fields are updated
    And the admin field is changed

  # Scenario:  Admin users can deactivate a user account
  #   Given I am signed in as an admin user
  #   And there is at least one other user
  #   When I visit the Users page
  #   And I see the window tile "Motley Users"
  #   And I see information for another user
  #   When I click the Deactivate button for that user
  #   Then the user is Deactivated
