#!/usr/bin/env bats
load test_helpers

@test "[$TEST_FILE] Check system Python version" {
    run launch python --version
    [[ ${lines[0]} =~ "Python 2.7" ]]
}

@test "[$TEST_FILE] Check that pyenv is installed" {
    run launch pyenv
    [[ ${lines[0]} =~ "pyenv 20" ]]
}

@test "[$TEST_FILE] Check system Python is pyenv default" {
    run launch pyenv version
    [[ ${lines[0]} =~ "system" ]]
}

@test "[$TEST_FILE] Check that custom scripts exist" {
    run launch [ -x /usr/local/bin/pyversions ]
    [ $status = 0 ] 

    run launch [ -x /usr/local/bin/requirements ]
    [ $status = 0 ] 

    # Sanity check
    run launch [ -x /usr/local/bin/foofile ]
    [ $status = 1 ] 
}
