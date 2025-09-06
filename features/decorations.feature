Feature: Decorations
  People come to a site for information and stay for usefulness and
  attractiveness.  We need to make sure that basic information is present in
  the general layout of every page.

  * There is a header on every page; it contains a logo and a navigation menu
  * There is a footer on every page; it contains a list of Friends Links, a
    copyright notice for the current year, a visit counter, a contact widget
  * There is a contact widget in the footer; it contains a Facebook Icon that
    links to the FB page and a contact email link

  Scenario: The header contains all expected elements
    Given I am not signed in
    When I look at the header of the home page
    Then I see a logo
    And I see a navigation menu

  Scenario: The footer contains all expected elements
    Given I am not signed in
    When I look at the footer of the home page
    Then I see a list of Friends Links
    And I see a copyright notice with the current year
    And I see a visit counter
    And I see a contact widget
    And I do not see a version number

  Scenario: The footer contains expected elements when logged in as admin
    Given I am signed in as an admin user
    When I look at the footer of the home page
    Then I see a version number

  Scenario: The contact widget has all expected elements
    Given I am not signed in
    When I look at the contact widget on the home page
    Then I see a Facebook tile/image that links to the FB page
