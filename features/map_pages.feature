Feature: Map Pages
  Scenario: Pages are stripped from their order
    Given the Server is running at "sample-book-app"
    When I go to "/chapter_one/first_page"
    Then I should see "Lorem ipsum"
