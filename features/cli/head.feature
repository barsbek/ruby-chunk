@head @command @cli
Feature: CLI command for getting first n lines
  In order to read first lines of file or files
  I want to be able to run "head" command
  with or without options

  Background:
    Given a file "first/file/path" with content
      """
      zeroth line of first file
      first line of first file
      second line of first file
      third line of first file
      fourth line of first file
      fifth line of first file
      sixth line of first file

      eighth line of first file
      nineth line of first file
      tenth line of first file
      eleventh line of first file
      twelveth line of first file
      thirteenth line of first file
      fourteenth line of first file
      last line of first file

      """
    Given a file "second/file/path" with content
      """
      zeroth line of second file
      first line of second file
      second line of second file
      third line of second file
      fourth line of second file
      fifth line of second file
      """

  Scenario: Get first 10 lines
    Given a file path "first/file/path"
    When I run command "head"

    Then result should contain "first/file/path"
    And result should contain "zeroth line of first file"
    And result should contain "nineth line of first file"

    And result shouldn't contain "tenth line of first file"
    And result shouldn't contain "last line of first file"

  Scenario: Get first n lines
    Given a file path "first/file/path"
    When I run command "head -n 5"

    Then result should contain "first/file/path"
    And result should contain "zeroth line of first file"
    And result should contain "fourth line of first file"

    And result shouldn't contain "sixth line of first file"
    And result shouldn't contain "last line of first file"

  Scenario: Get last n lines
    Given a file path "first/file/path"
    When I run command "head -n 5 -c 6"

    Then result should contain "first/file/path"
    And result should contain "zeroth"
    And result shouldn't contain " line of first file"
    And result should contain "fourth"
    And result shouldn't contain " line of first file"

    And result shouldn't contain "sixth line of first file"
    And result shouldn't contain "last line of first file"


  Scenario: Get "is not found" message, when file don't exist
    Given nonexisting file's path
    When I run command "head"
    Then result should contain "nonexisting/file/path"
    And result should contain "is not found"

  Scenario: Get first n lines of each specified file
    Given a list of files
      | first/file/path  |
      | second/file/path |
    When I run command "head -n 3"

    Then result should contain "first/file/path"
    And result should contain "zeroth line of first file"
    And result should contain "second line of first file"
    And result shouldn't contain "third line of first file"
    And result shouldn't contain "last line of first file"

    Then result should contain "second/file/path"
    And result should contain "zeroth line of second file"
    And result should contain "second line of second file"
    And result shouldn't contain "third line of second file"
    And result shouldn't contain "fifth line of second file"
