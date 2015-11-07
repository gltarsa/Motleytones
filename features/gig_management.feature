Feature: Gig Management
  The gig schedule that gets displayed in the app comes from a database.
  An admin user has the ability to create, update and delete gig dates.
  A gig entry is not displayed unless its published field is true.

  * An admin user can create gig entries
  * An admin user can delete gig entries
  * An admin user can edit gig entries
  * A user who is not signed in cannot access any gig management features (add, edit)
  * A non-admin user cannot access any gig management features (add, edit)
  - A non-admin user sees only published gigs
  - A user who is not signed in sees only published gigs
  - An admin user sees published and unpublished gigs
  - An admin user can change the publish state of a gig
  c Only gig entries with with a true published flag are put into the schedule.
  c An admin user can see a list of all gig entries displayed in field format.

  @javascript
  Scenario: An admin user can create gig entries
    Given I am signed in as an admin user
    When I navigate to the Add Gig page
    And I fill in the gig fields
    And I click Add Gig
    Then the gig is created
    And I see the gig on both schedule pages

  @javascript
  Scenario: An admin user can delete gig entries
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Performance Schedule page
    Then I see information for a gig
    When I click Delete and confirm deletion for that gig
    Then that gig is deleted

  @javascript
  Scenario: An admin user can edit gig entries
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Performance Schedule page
    When I click Edit for the first gig
    Then I am sent to the Change Gig page
    When I change the gig fields
    And I click Update
    Then the gig fields are changed

  @javascript
  Scenario: A user who is not signed in cannot access any of the gig management feature (add, edit)s
    Given I am not signed in
    When I look at the Navigation Menu
    And I do not see an Add Gig link

    When I navigate to the Performance Schedule page
    Then I do not see an edit button
    And I do nto see a delete button

    When I visit the Add Gig page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Edit Gig page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

  @javascript
  Scenario: A non-admin user cannot access any gig management features (add, edit)
    Given I am signed in as a non-admin user
    When I look at the Navigation Menu
    And I do not see an Add Gig link

    When I navigate to the Performance Schedule page
    Then I do not see an edit button
    And I do nto see a delete button

    When I visit the Add Gig page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

    When I visit the Edit Gig page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

  # TODO:  non-display/display of unpublished gigs is a future feature
  # but the tests are defined here since I have thought them out already.
  # @javascript
  # Scenario: An admin user can see a list of all gig entries displayed in field format.
  #   Given I am signed in as an admin user
  #   And there is at least one published gig
  #   When I navigate to the Performance Schedule page
  #   Then I see information for a gig

  # @javascript
  # Scenario: Only gig entries with with a true published flag are put into the schedule.
  #   Given I am signed in as an admin user
  #   And there is at least one published gig
  #   And there is at least one unpublished gig
  #   When I go to the Schedule Page
  #   Then I see the published gig
  #   And I do not see the unpublished gig

  @javascript
  Scenario: A
