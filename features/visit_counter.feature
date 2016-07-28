Feature: Visit Counter
  The owner of the site would like to know how many people visit the
  site so there should be a visit count on every page.

  * When a new user visits a page then the visit counter increases

  @javascript
  Scenario: A new user visiting the page increases the visit count
    Given I am not signed in
    When a new visitor visits the page
    Then the visit counter increases by 1
