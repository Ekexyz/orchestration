*** Settings ***
Resource                    ../resources/common.resource
Suite Setup                 Startup
Suite Teardown              Closure

*** Test Cases ***
Orchestration
    [Documentation]         Read/Write YAML and proceed with test execution as defined.
    [Tags]                  ORCHESTRATE


    # Create paths for previous build information in YAML
    ${last_build}=          Create List                 execute                     build
    ${last_run}=            Create List                 execute                     name
    ${last_status}=         Create List                 execute                     status

    # Read previous build information from YAML
    ${test_name}=           Get Value                   ${last_run}
    ${test_status}=         Get Value                   ${last_status}
    ${test_build}=          Get Value                   ${last_build}

    IF                      ${test_name} is not None
        Log To Console      Last test run was: ${test_name} with build_id: ${test_build}
        # Verify status of previous run
        ${response}=        Get Build Status  project_id=${project_id}    suite_id=${suite_id}  build_id=${test_build}
    ELSE
        ${tests}=           Create List                 tests
        ${tests}=           Get Value                   ${tests}
        Log To Console      ${tests}
        ${test}=            Set Variable                ${tests}[0][name]
    END

    # TODO: save and include suite level variables from previous run to the next
    ${test_parameter}=      Create Dictionary           key=--test                  type=clp                value=${test}
    ${input_parameters}=    Create List                 ${test_parameter}

    # Execute test
    ${response}=            Start Test Run              project_id=${project_id}    suite_id=${suite_id}    input_parameters=${input_parameters}

    # Get response values
    ${build_id}=            Set Variable                ${response}[data][id]
    ${status}=              Set Variable                ${response}[data][status]

    Update Value            path=${last_build}               value=${build_id}
    Save Yaml
    Commit And Push         file_name=orchestration.yaml  git_branch=main

