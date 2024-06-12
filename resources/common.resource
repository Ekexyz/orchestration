*** Settings ***
Library    QForce
Library    Collections
Library    String
Library    OperatingSystem
Library    ../libraries/GitOperations.py
Library    ../libraries/YamlEditor.py
Library    ../libraries/CRTApi.py  api_url=https://api.robotic.copado.com/pace/v4  access_token=${pat}


*** Variables ***
${git_branch}           main
${pat}                  ${EMPTY}

*** Keywords ***
Startup
    [Documentation]  Startup steps
    # Read 
    # Read YAML to see which test to execute

Closure
    [Documentation]  Teardown steps
    # Markdown to YAML the statuses etc.
