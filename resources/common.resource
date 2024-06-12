*** Settings ***
Library    QForce
Library    Collections
Library    String
Library    OperatingSystem
Library    ../libraries/GitOperations.py
Library    ../libraries/YamlEditor.py

*** Variables ***
${git_branch}           main
${pat}                  ${EMPTY}

*** Keywords ***
Startup
    [Documentation]  Startup steps

Closure
    [Documentation]  Teardown steps
