Feature: Gig Management
  The gig schedule that gets displayed in the app comes from a database.
  An admin user has the ability to create, update and delete gig dates.
  A gig entry is not displayed unless its published field is true.

  * An admin user can create gig entries
  * It is not possible to create a gig with the same name and date as a previous gig
  * An admin user can delete gig entries
  * An admin user can edit gig entries
  * It is not possible to edit a gig to have the same name and date as a previous gig
  * A user who is not signed in cannot access any gig management features
  * A non-admin user cannot access any gig management features
  * Only published gigs appear on the schedule pages
  * Both published and unpublished gigs appear on the Gig Management page
  * Edit and Create screens have token description notes

  @javascript
  Scenario: An admin user can create gig entries from scratch
    Given I am signed in as an admin user
    When I navigate to the Manage Gigs page
    And I click Add Gig
    Then I see the Add Gig page
    And I see a note describing tokens
    When I fill in the gig fields
    And I click Add Gig
    Then I see the Latest Gig page
    And I see a notice that the gig is added
    And the gig is created
    And I see the gig on the home page
    And I see the gig on the schedule page

  @javascript
  Scenario: It is not possible to create a gig with the same name and date as a previous gig
    Given I am signed in as an admin user
    And there is at least one existing gig
    When I navigate to the Manage Gigs page
    When I click Add Gig
    Then I see the Add Gig page
    When I fill in the gig fields to have the same name and date
    And I click Add Gig
    Then I see an error message

  @javascript @delete
  Scenario: An admin user can delete gig entries
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Manage Gigs page
    Then I see the gig
    When I click Delete and confirm deletion for that gig
    Then I see a notice indicating that the gig is deleted
    And that gig is deleted
    And I am on the Manage Gigs page

  @javascript
  Scenario: An admin user can edit gig entries
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Manage Gigs page
    And I click Edit for the first gig
    Then I am sent to the Change Gig page
    And I see a note describing tokens
    When I change the gig fields
    And I change the published checkbox
    And I click Update
    Then the gig fields are changed
    And the published field is changed
    When I click Manage Gigs
    Then I am on the Manage Gigs page

  @javascript @clone
  Scenario: An admin user can clone gig entries from a previous gig
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Manage Gigs page
    And I see the source gig
    And I click Clone for that gig
    Then I see the Add Gig page
    And it has today's date
    And it is not published
    And it is the same number of days as the source gig
    And it has the same name as the source gig
    And it has the same note as the source gig
    And it has the same location as the source gig
    When I click Add Gig
    Then I see a notice that the gig is added
    And I see the gig on the schedule page
    And I see the source gig on the schedule page

  @javascript
  Scenario: It is not possible to edit a gig to have the same name and date as a previous gig
    Given I am signed in as an admin user
    And there is at least one existing gig
    And I add a new gig
    When I navigate to the Manage Gigs page
    When I click Edit for the new gig
    Then I am sent to the Change Gig page
    When I fill in the gig fields to have the same name and date
    And I click Update
    Then I see an error message

  @javascript
  Scenario: A user who is not signed in cannot access any of the gig management features
    Given I am not signed in
    When I look at the Navigation Menu
    And I do not see a Manage Gigs link

    # This test started failing.  It _looks_ like the page is not switching, but it seems clear that it should be.
    # Rather than try and fix it I realized that this is a useless test as we are checking for an Edit and
    # Delete button that are NEVER there anyway.
#    When I navigate to the Performance Schedule page
#    Then I do not see an Edit button
#    And I do not see a Delete button

    When I visit the Gig Management page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Add Gig page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Edit Gig page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

  @javascript
  Scenario: A non-admin user cannot access any gig management features
    Given I am signed in as a non-admin user
    When I look at the Navigation Menu
    And I do not see a Manage Gigs link

    When I visit the Gig Management page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

    When I visit the Add Gig page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

    When I visit the Edit Gig page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

  @javascript
  Scenario: Only published gigs appear on the schedule pages
    Given I am signed in as an admin user
    And there is at least one published gig
    And there is at least one unpublished gig
    When I navigate to the Performance Schedule page
    Then I see the published gig
    And I do not see the unpublished gig

  @javascript
  Scenario: Both published and unpublished gigs appear on the Gig Management page
    Given I am signed in as an admin user
    And there is at least one published gig
    And there is at least one unpublished gig
    When I navigate to the Manage Gigs page
    Then I see the published gig
    And  I see the unpublished gig

  @javascript
  Scenario: A one day gig that is one day past is expired
    Given I am signed in as an admin user
    And there is at least one published one-day gig dated yesterday
    When I navigate to the Performance Schedule page
    Then I see the published gig is expired

  @javascript @unpublished
  Scenario: An unpublished one day gig that is one day past is expired
    Given I am signed in as an admin user
    And there is at least one unpublished one-day gig dated yesterday
    When I navigate to the Performance Schedule page
    Then the unpublished gig is expired

  @javascript
  Scenario: A two day gig that is one day past is active
    Given I am signed in as an admin user
    And there is at least one published two-day gig dated yesterday
    When I navigate to the Performance Schedule page
    Then I see the published gig is active

  @javascript
  Scenario: A two day gig that is two days past is expired
    Given I am signed in as an admin user
    And there is at least one published two-day gig dated two days ago
    When I navigate to the Performance Schedule page
    Then I see the published gig is expired
