*** Settings ***
Library         QForce
Resource        ../resources/common.resource
Suite Setup     OpenBrowser  about:blank  chrome
Suite Teardown  CloseAllBrowsers

*** Test Cases ***
Test1
    [Documentation]  passing test case
    [Tags]           test1
    Log    Starting ${TEST NAME}  console=True
    Add Global Variable  key=opportunity_id  value=123456
    Save Yaml
    #Commit And Push                         file_name=orchestration.yaml                        git_branch=main
    Sleep  5
    Pass Execution  message=${TEST NAME} finished

Test2
    [Documentation]  failing test case, will simulate waiting for a status to be correct
    [Tags]           test2
    Log    Starting ${TEST NAME}  console=True
    Add Global Variable  opportunity_id  654321
    Save Yaml
    #Commit And Push                         file_name=orchestration.yaml                        git_branch=main
    Sleep  5
    Fail  msg=${TEST NAME} will fail here..


Test3
    [Documentation]  passing test case
    [Tags]           test3
    Log    Starting ${TEST NAME}  console=True
    Add Global Variable  opportunity_id  112233
    Save Yaml
    #Commit And Push                         file_name=orchestration.yaml                        git_branch=main
    Sleep  5
    Pass Execution  message=${TEST NAME} finished