*** Settings ***
Resource    ../resources/common.resource
Suite Setup     Startup
Suite Teardown  Closure



*** Test Cases ***
Test1
    [Documentation]
    [Tags]
    Log    Starting ${TEST NAME}  console=True
    Pass Execution  message=${TEST NAME} finished

Test2
    [Documentation]
    [Tags]
    Log    Starting ${TEST NAME}  console=True
    Pass Execution  message=${TEST NAME} finished










