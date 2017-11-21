@lines @cli @commands
Feature: CLI's lines command
  In order to get info about lines number
  I want to be able to run "lines" command
  
  Background:
    Given a file "first/file/path" with content
      """
      Content of the first file.
      With some Lorem Ipsum.
      """
    Given a file "second/file/path" with content
      """
      Content of the second file
      """

  Scenario: Get number of lines of the file
    Given a file path "first/file/path"
    When I run command "lines"
    Then result should contain "first/file/path"
    And result should contain ": 2"
    And result shouldn't contain "Total"

  Scenario: Get number of lines of each specified file
    Given a list of files
      | first/file/path  |
      | second/file/path |
    When I run command "lines"
    Then result should contain "first/file/path"
    And result should contain ": 2"

    Then result should contain "second/file/path"
    And result should contain ": 1"

    And result should contain "Total: 3"

  Scenario: Get "is not found" message, when file don't exist
    Given nonexisting file's path
    When I run command "lines"
    Then result should contain "nonexisting/file/path"
    And result should contain "is not found"
