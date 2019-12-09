#!/bin/sh
set -e;

# PIDの削除
rm -rf /app/tmp/pids/*.pid;

exec "$@";
