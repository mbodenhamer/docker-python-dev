#!/usr/bin/env bats
load test_helpers

#-------------------------------------------------------------------------------

@test "[$TEST_FILE] Pre-depman Test" {
    run launch pip show weaver
    [ $status = 1 ] # Package weaver not installed in base image

    run launch which dc
    [ $status = 1 ] # dc not installed
}

#-------------------------------------------------------------------------------

@test "[$TEST_FILE] Build Test 1" {
    docker build -t ${ONBUILD_NAME}:latest --build-arg versions="" /app/tests
}

@test "[$TEST_FILE] depman Test" {
    run launch_build pip show weaver
    [ $status = 0 ] # Package weaver is installed in onbuild image

    run launch_build which dc
    [ $status = 0 ] # dc installed
}

@test "[$TEST_FILE] pyversions null test" {
    run launch_build pyenv versions
    [[ ${#lines[@]} == 1 ]] # only system version installed
    [[ ${lines[0]} =~ "system" ]]
}

@test "[$TEST_FILE] Build Test 1 Teardown" {
    docker rmi ${ONBUILD_NAME}
}

#-------------------------------------------------------------------------------

@test "[$TEST_FILE] Build Test 2" {
    docker build -t ${ONBUILD_NAME}:latest --build-arg versions="2.7.13,3.6.1" \
	--build-arg reqs=requirements2.yml /app/tests
}

@test "[$TEST_FILE] depman Test 2" {
    run launch_build pip show weaver
    [ $status = 0 ] # Package weaver is installed in onbuild image

    run launch_build which dc
    [ $status = 1 ] # dc not installed
}

@test "[$TEST_FILE] pyversions install test" {
    run launch_build pyenv versions
    [[ ${#lines[@]} == 3 ]] # 3 versions installed
    [[ ${lines[0]} =~ "system" ]]
    [[ ${lines[1]} =~ "2.7.13" ]]
    [[ ${lines[2]} =~ "3.6.1" ]]
}

@test "[$TEST_FILE] Build Test 2 Teardown" {
    docker rmi ${ONBUILD_NAME}
}

#-------------------------------------------------------------------------------
