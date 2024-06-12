*** Settings ***
Library    QForce
Library    Collections
Library    String
Library    OperatingSystem
Library    ../libraries/GitOperations.py
Library    ../libraries/YamlEditor.py  filename=${CURDIR}/../files/orchestration.yaml
Library    ../libraries/CRTApi.py  api_url=https://api.robotic.copado.com/pace/v4  access_token=${pat}


*** Variables ***
${git_branch}           main
${pat}                  ${EMPTY}

*** Keywords ***
Startup
    [Documentation]  Startup steps
    # Read environment variables for project and suite
    ${project_id}=  Get Environment Variable  PROJECT_ID
    ${suite_id}=    Get Environment Variable  JOB_ID
    Set Suite Variable  ${project_id}
    Set Suite Variable  ${suite_id}

