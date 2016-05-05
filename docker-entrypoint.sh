#!/bin/bash

# Execute whatever was passed into docker run, but retain control of the shell
( exec "$@" )
EXIT=$?

# Reset ownership of affected files
set -e
find /app -uid 0 -exec chown -h $BE_UID {} \+
find /app -gid 0 -exec chgrp -h $BE_GID {} \+
exit $EXIT
