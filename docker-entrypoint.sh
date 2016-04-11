#!/bin/bash

# Execute whatever was passed into Docker run, but retain control of the shell
exec "$@" &>/dev/tty | true

# Reset ownership of affected files
find /app -uid 0 -exec chown -h $BE_UID {} \+
find /app -gid 0 -exec chgrp -h $BE_GID {} \+
