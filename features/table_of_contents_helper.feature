Feature: Table of Contents
  Scenario: Table of contents is generated from the filesystem structure
    Given the Server is running at "sample-book-app"
    When I go to "/"
    Then I should see "Chapter One"
    Then I should see "Chapter Two"
    Then I should see:
    """
    <a href="/chapter_one/first_page.html">First Page</a>
    """
    Then I should see "Second Page"
    Then I should see "Third Page"
    Then I should see "Fourth Page"

