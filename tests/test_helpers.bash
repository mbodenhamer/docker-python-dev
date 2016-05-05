TEST_FILE=$(basename $BATS_TEST_FILENAME .bats)
TEST_DIR=$(dirname $BATS_TEST_FILENAME)

function launch {
    docker run --rm -it -v $(pwd):/app mbodenhamer/python-dev:latest "$@"
}
