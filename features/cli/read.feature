@read @command @cli
Feature: CLI "read" command
  In order to read some part of the FILES
  I want to be able to run "read" command
  With or without options

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
    Given a file "third/file/path" with content
      """
      And content of the third file
      """

  Scenario: Read entire file
    Given a file path "first/file/path"
    When I run command "read"
    Then result should contain "first/file/path"
    And result should contain "Content of the first file"

  Scenario: Read entire content of every specified files
    Given a list of files
      | first/file/path  |
      | second/file/path |
      | third/file/path  |
    When I run command "read"

    Then result should contain "first/file/path"
    And result should contain "second/file/path"
    And result should contain "third/file/path"

    And result should contain "Content of the first file"
    And result should contain "Content of the second file"
    And result should contain "And content of the third file"

  Scenario: Read first 5 bytes of the file's each line
    Given a file path "first/file/path"
    When I run command "read --line-bytes 5"
    Then result should contain "first/file/path"
    
    And result should contain "Conte"
    And result shouldn't contain "nt of the first file."

    And result should contain "With "
    And result shouldn't contain "some Lorem Ipsum"

  Scenario: Read first 5 bytes of the file
    Given a file path "first/file/path"
    When I run command "read --bytes 5"

    Then result should contain "Conte"
    And result shouldn't contain "nt of the first file."
    And result shouldn't contain "With some Lorem Ipsum."

  Scenario: Read first 2 bytes from each line of multiple files
    Given a list of files
      | first/file/path  |
      | second/file/path |
      | third/file/path  |
    When I run command "read --line-bytes 10"

    Then result should contain "first/file/path"
    And result should contain "Co"
    And result shouldn't contain "ntent of the first file."
    And result should contain "Wi"
    And result shouldn't contain "th some Lorem Ipsum"

    And result should contain "second/file/path"
    And result should contain "Co"
    And result shouldn't contain "ntent the second file"

    And result should contain "third/file/path"
    And result should contain "An"
    And result shouldn't contain "d Content of the third file"

  Scenario: Read first 5 bytes from each of specified files
    Given a list of files
      | first/file/path  |
      | second/file/path |
      | third/file/path  |
    When I run command "read --bytes 5"

    Then result should contain "Conte"
    And result shouldn't contain "nt of the first file."
    And result shouldn't contain "With some Lorem Ipsum."

    And result should contain "Conte"
    And result shouldn't contain "nt of the second file"

    And result should contain "And c"
    And result shouldn't contain "ontent of the third file"
