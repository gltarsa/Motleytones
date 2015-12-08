Feature: User Management
  There are two classes of users who can log into the system.
  Most users will be ordinary, aka non-admin users.  Some
  will have admin privileges.

  Admin users have the ability to change any profiles and
  delete any account but his own.

  * A user who is not signed up cannot access any of the user management buttons on the Manage Pirates page.
  * A non-admin user cannot add a new user
  * It is not possible to create a user with the same name as an existing user
  * It is not possible to edit a user record to have the same name as an existing user
  * A non-admin user can manage his own profile information,
    but cannot delete his account.

  @javascript
  Scenario: A user can sign into the system with registered email and password
    Given I am not signed in
    When I navigate to the Sign In page
    And I enter a registered email
    And I enter the associated password
    And I click Sign In
    Then I am sent to the Profile page
    And I see the new user name
    And I see a success message containing "Signed in successfully"

  @javascript
  Scenario: A user cannot sign into the system with an unregistered email or password
    Given I am not signed in
    When I navigate to the Sign In page
    And I enter an unregistered email
    And I enter an invalid password
    And I click Sign In
    Then I see an alert containing "Invalid email or password"
    When I enter a registered email
    And I enter an invalid password
    And I click Sign In
    Then I see an alert containing "Invalid email or password"

  @javascript
  Scenario: A user who is not signed in cannot access any of the user management features
    Given I am not signed in
    When I look at the Navigation Menu
    Then I do not see a Manage Pirates link
    And I do not see a Profile link
    And I do not see a Sign Out link

    When I visit the Manage Pirates page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Add Pirate page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Edit Profile page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

  @javascript
  Scenario: A non-admin user cannot add a new user
    Given I am signed in as a non-admin user
    When I look at the Navigation Menu
    Then I do not see an Add Pirate link

    When I visit the Add Pirate page directly
    Then I am sent to the Root page
    And I see an alert containing "You must be an admin user to access that page"

  @javascript
  Scenario: A non-admin user cannot delete his own profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    And I do not see a Delete button

  @javascript
  Scenario: A non-admin user can edit his own profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click Edit
    Then I am sent to the Change Pirate Information page
    When I change the mutable fields
    And I click Update
    Then the mutable fields are changed

  @javascript
  Scenario: A non-admin user cannot change his admin status
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click Edit
    Then I am sent to the Change Pirate Information page
    When I change the admin checkbox
    And I click Update
    And the admin field is not changed

  @javascript @admin
  Scenario: A non-admin user can cancel the edit of his profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click Edit
    Then I am sent to the Change Pirate Information page
    When I change the mutable fields
    And I click Cancel
    Then the mutable fields are not changed

  @javascript @admin
  Scenario: Admin users can create a new user account
    Given I am signed in as an admin user
    When I navigate to the Add Pirate page
    And I fill in the fields
    And I click Add pirate
    Then the account is created
    And I am still in the admin account

  @javascript @admin
  Scenario: It is not possible to create a user with the same name as an existing user
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Add Pirate page
    And I fill in the fields so that the name matches the exising user
    And I click Add pirate
    Then I see an error message
    And the user is not created

  @javascript @admin
  Scenario:  Admin users can delete a user account
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Manage Pirates page
    Then I see information for another user
    When I click Delete and confirm deletion for that other user
    Then that other user is deleted

  @javascript @admin
  Scenario:  Admin users cannot delete their own account
    Given I am signed in as an admin user
    When I navigate to the Profile page
    And I do not see a Delete button

  @javascript @admin
  Scenario:  Admin users can edit a user account from the Manage Pirates Page
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Manage Pirates page
    And I click Edit for that other user
    Then I am sent to the Change Pirate Information page
    When I change the mutable fields for that other user
    And I change the admin checkbox
    And I click Update
    Then the mutable fields for that other user are changed
    And the admin field is changed

  @javascript @admin
  Scenario:  It is not possible to edit a user record to have the same name as an existing user
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Manage Pirates page
    And I click Edit for that other user
    Then I am sent to the Change Pirate Information page
    When I change the name of the user to be the same as the other user
    And I click Update
    Then I see an error message
    And the user is not changed
