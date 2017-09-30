#!/usr/bin/env bats
load test_helpers

@test "[$TEST_FILE] Pre-depman Test" {
    run launch pip show weaver
    [ $status = 1 ] # Package weaver not installed in base image
}

@test "[$TEST_FILE] Build Test 1" {
    cp /app/tests/requirements.yml /tmp/requirements.yml
    docker build -t ${ONBUILD_NAME}:latest --build-arg versions="" \
	--build-arg reqs=/tmp/requirements.yml /app/tests
    rm /tmp/requirements.yml
}

@test "[$TEST_FILE] depman Test" {
    run launch_build pip show weaver
    [ $status = 0 ] # Package weaver is installed in onbuild image
}

@test "[$TEST_FILE] pyversions null test" {
    run launch_build pyenv versions
    [[ ${#array[@]} == 1 ]] # only system version installed
    [[ ${lines[0]} =~ "system" ]]
}

@test "[$TEST_FILE] Build Test 1 Teardown" {
    docker rmi ${ONBUILD_NAME}
}

# Pyversions test;  Test that requested Python versions are installed



# dist-test test


