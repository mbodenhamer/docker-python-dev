TEST_FILE=$(basename $BATS_TEST_FILENAME .bats)
TEST_DIR=$(dirname $BATS_TEST_FILENAME)

ONBUILD_NAME=foobarbaz

function launch {
    docker run --rm -it -v /tmp:/tmp mbodenhamer/python-dev:latest "$@"
}

function launch_build {
    docker run --rm -it -v /tmp:/tmp ${ONBUILD_NAME}:latest "$@"
}
