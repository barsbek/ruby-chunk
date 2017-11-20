Feature: CLI interface
  In order to read some part of the FILES
  I want to be able to execute specific commands

  Background:
    Given files with content
      |path            |content                  |
      |first/file/path |Content of first file    |
      |second/file/path|Content of second file   |
      |third/file/path |And Content of third file|

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
