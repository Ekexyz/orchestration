*** Settings ***
Resource        ../resources/common.resource
Suite Setup     Startup
Suite Teardown  Closure

*** Test Cases ***
Orchestration
    [Documentation]  Read YAML and proceed with test execution as defined.
    ...              These steps are defined in the resource file.
    [Tags]           ORCHESTRATE
    # this will do nothing except run other tests
    No Operation
