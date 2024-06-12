*** Settings ***
Resource                    ../resources/common.resource
Suite Setup                 Startup


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

    # All defined tests
    ${tests}=               Create List                 tests
    ${tests}=               Get Value                   ${tests}

    # Run logic
    IF                      "${test_name}" != "${EMPTY}"
        Log To Console      Last test run was: ${test_name} with build_id: ${test_build}
        # Verify status of previous run
        ${response}=        Get Build Status            project_id=${project_id}    suite_id=${suite_id}    build_id=${test_build}
        ${status}=          Set Variable                ${response}[data][status]
        IF                  "${status}" == "executing"
            Pass Execution                              message=Previous run is still executing
        ELSE IF             "${status}" == "queued"
            Pass Execution                              message=Previous run is still in the queue
        ELSE IF             "${status}" == "succeeded"
            Log To Console                              Previous run has completed successfully. Starting the next run.
            ${last_index}=                              Evaluate                    next((index for (index, d) in enumerate($tests) if d["name"] == "${test_name}"), None)
            ${next_index}=                              Evaluate                    ${last_index} +1
            TRY
                ${test}=        Set Variable                ${tests}[${next_index}][name]
            EXCEPT
                # Cleanup YAML
                Update Value                            path=${last_build}          value=${EMPTY}
                Update Value                            path=${last_run}            value=${EMPTY}
                Update Value                            path=${last_status}         value=${EMPTY}
                Save Yaml
                Commit And Push                         file_name=orchestration.yaml                        git_branch=main
                # Pass execution
                Pass Execution                          message=Next test not defined, restoring to initial state.
            END
        ELSE
        # TBD.
            Fail            msg=Last test run failed with status: ${status} and buildId: ${test_build}. Please check the issue and restore the yaml state.
        END
    ELSE
        ${test}=            Set Variable                ${tests}[0][name]
        Log To Console      Running the first test: ${test}
    END

    # TODO: save and include suite level variables from previous run to the next
    ${test_parameter}=      Create Dictionary           key=--test                  type=clp                value=${test}
    ${input_parameters}=    Create List                 ${test_parameter}

    # Execute test
    ${response}=            Start Test Run              project_id=${project_id}    suite_id=${suite_id}    input_parameters=${input_parameters}

    # Get response values
    ${build_id}=            Set Variable                ${response}[data][id]
    ${status}=              Set Variable                ${response}[data][status]

    Update Value            path=${last_build}          value=${build_id}
    Update Value            path=${last_run}            value=${test}
    Update Value            path=${last_status}         value=${status}

    Save Yaml
    Commit And Push         file_name=orchestration.yaml                            git_branch=main

