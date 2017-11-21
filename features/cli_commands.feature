Feature: CLI commands
  In order to read some part of the FILES
  I want to be able to execute specific commands

  Background:
    Given a file "first/file/path" with content
      """
      Content of first file.
      Lorem Ipsum is simply dummy
      text of the printing and typesetting
      industry. Lorem Ipsum has been
      the industry's standard dummy text
      ever since the 1500s, when an unknown
      printer took a galley of type
      and scrambled it to make a
      type specimen book.
      It has survived not
      only five centuries, but also
      the leap into electronic typesetting,
      remaining essentially unchanged.
      It was popularised in the 1960s with
      the release of Letraset sheets
      containing Lorem Ipsum passages,
      and more recently with desktop
      publishing software like Aldus
      PageMaker including versions.
      """
    Given a file "second/file/path" with content
      """
      Content of second file
      """
    Given a file "third/file/path" with content
      """
      And Content of third file
      """

  Scenario: 
    Given a file path "first/file/path"
    When I run command "read"
    Then I want result to include
      |Content of first file|
  
  Scenario:
    Given a list of file-paths
      |first/file/path |
      |second/file/path|
      |third/file/path |
    When I run command "read"
    Then I want result to include
      |Content of first file    |
      |Content of second file   |
      |And Content of third file|
  
  Scenario:
    Given a file path "first/file/path"
    When I run command "read"
    Then I want result to include file's path
      |first/file/path|

  Scenario:
    Given a file path "first/file/path"
    When I run command "range"
    Then I want result to include
      |Content of first file|

  Scenario:
    Given a file path "first/file/path"
    When I run command "head"
    Then I want result to include first 10 lines

  Scenario:
    Given a file path "first/file/path"
    When I run command "tail"
    Then I want result to include last 10 lines
