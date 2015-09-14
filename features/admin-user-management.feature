Feature: Admin User Management
  As an admin user, I can create and manage user accounts.

  Scenario: Admin users can create new user accounts
    Given I am signed in as an admin user
    When I visit the Sign Up page
    Then I see the page title "Add New Motley Tone"
    And I see the user_name field
    And I see the tone_name field
    And I see the email field
    And I see the password and password_confirmation fields
    And I see the admin checkbox
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

  Scenario:  Admin users can deactivate a user account
    Given I am signed in as an admin user
    And there is at least one other user
    When I visit the Users page
    And I see the window tile "Motley Users"
    And I see information for another user
    When I click the Deactivate button for that user
    Then the user is Deactivated

  Scenario:  Admin users can edit a user account
    Given I am signed in as an admin user
    And there is at least one other user
    When I visit the Users page
    And I see the window tile "Motley Users"
    And I see information for another user
    When I click the Edit button for that user
    Then I see the page title "Change User Information"
    And I see an Update button
    When I change the user_name field
    And I change the user_name field
    And I change the tone_name field
    And I change the email field
    And I change the admin checkbox
    And I click the Update button
    Then the user fields are updated

