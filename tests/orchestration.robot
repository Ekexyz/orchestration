*** Settings ***
Resource        ../resources/common.resource
Suite Setup     Startup
Suite Teardown  Closure

*** Test Cases ***
Orchestration
    [Documentation]  Read YAML and proceed with test execution as defined.
    ...              These steps are defined in the resource file.
    [Tags]           ORCHESTRATE
    # Read YAML to see which test to execute
    ${test_parameter}=  Create Dictionary  key=--test  type=clp  value=Test1
    ${input_parameters}=  Create List  ${test_parameter}
    ${response}=  Start Test Run  project_id=${project_id}  suite_id=${suite_id}  input_parameters=${input_parameters}
    # Execute test
