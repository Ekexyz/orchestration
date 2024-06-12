*** Settings ***
Library         QForce
Suite Setup     OpenBrowser  about:blank  chrome
Suite Teardown  CloseAllBrowsers



*** Test Cases ***
Test1
    [Documentation]
    [Tags]
    Log    Starting ${TEST NAME}  console=True
    Sleep  5
    Pass Execution  message=${TEST NAME} finished

Test2
    [Documentation]
    [Tags]
    Log    Starting ${TEST NAME}  console=True
    Sleep  5
    Pass Execution  message=${TEST NAME} finished
