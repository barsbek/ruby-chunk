@range @command @cli
Feature: CLI command for getting lines range
  In order to get range of lines from file or files
  I want to be able to run "range" command
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

  Scenario: Read entire file
    Given a file path "first/file/path"
    When I run command "range"

    Then result should contain "first/file/path"
    And result should contain "zeroth line of first file"
    And result should contain "eighth line of first file"
    And result should contain "last line of first file"

  Scenario: Read lines beginning from the specified line
    Given a file path "first/file/path"
    When I run command "range -f 10"
    
    Then result should contain "first/file/path"
    And result should contain "tenth line of first file"
    And result should contain "last line of first file"

    And result shouldn't contain "zeroth line of first file"
    And result shouldn't contain "eighth line of first file"

  Scenario: Read lines until the specified line
    Given a file path "first/file/path"
    When I run command "range -t 10"
    
    Then result should contain "first/file/path"
    And result should contain "zeroth line of first file"
    And result should contain "tenth line of first file"

    And result shouldn't contain "eleventh line of first file"
    And result shouldn't contain "last line of first file"

  Scenario: Read lines in a specified range
    Given a file path "first/file/path"
    When I run command "range -f 9 -t 13"

    Then result should contain "first/file/path"
    And result shouldn't contain "zeroth line of first file"
    And result shouldn't contain "eighth line of first file"

    And result should contain "nineth line of first file"
    And result should contain "thirteenth line of first file"

    And result shouldn't contain "fourteenth line of first file"
    And result shouldn't contain "last line of first file"

  Scenario: Read particular number of bytes from each line in a specified range 
    Given a file path "first/file/path"
    When I run command "range -f 9 -t 13 -c 5"

    Then result should contain "first/file/path"
    And result shouldn't contain "zeroth line of first file"
    And result shouldn't contain "eighth line of first file"

    And result should contain "ninet"
    And result shouldn't contain "h line of first file"
    And result should contain "thirt"
    And result shouldn't contain "eenth line of first file"

    And result shouldn't contain "fourteenth line of first file"
    And result shouldn't contain "last line of first file"
  
  Scenario: Get "is not found" message, when file don't exist
    Given nonexisting file's path
    When I run command "head"
    Then result should contain "nonexisting/file/path"
    And result should contain "is not found"

  Scenario: Get range of lines from multiple files
    Given a list of files
      | first/file/path  |
      | second/file/path |
    When I run command "range -f 3 -t 8"

    Then result should contain "first/file/path"
    And result shouldn't contain "zeroth line of first file"
    And result shouldn't contain "second line of first file"
    And result should contain "third line of first file"
    And result should contain "eighth line of first file"
    And result shouldn't contain "nineth line of first file"
    And result shouldn't contain "last line of first file"
    
    Then result should contain "second/file/path"
    And result shouldn't contain "zeroth line of first file"
    And result shouldn't contain "second line of first file"
    And result should contain "third line of first file"
    And result should contain "fifth line of first file"
    

