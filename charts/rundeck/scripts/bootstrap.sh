#!/bin/bash

set -e

CONFIG_SRC=/home/rundeck/custom/rundeck-config/rundeck-config-append.properties
if test -f "$CONFIG_SRC"; then
    echo "Applying custom rundeck-config.properties"
    mkdir -p /tmp/remco-partials/rundeck-config
    cp "$CONFIG_SRC" /tmp/remco-partials/rundeck-config/rundeck-config-custom.properties
fi

echo "Copying custom plugins"
cp -r /mnt/plugins/. /home/rundeck/libext

echo "Continue with common bootstrap"
exec /home/rundeck/docker-lib/entry.sh