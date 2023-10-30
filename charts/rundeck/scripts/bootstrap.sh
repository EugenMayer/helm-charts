#!/bin/bash

set -e

CONFIG_SRC=/home/rundeck/custom/rundeck-config/rundeck-config-append.properties
if test -f "$CONFIG_SRC"; then
    echo "Applying custom rundeck-config.properties"
    mkdir -p /tmp/remco-partials/rundeck-config
    cp "$CONFIG_SRC" /tmp/remco-partials/rundeck-config/rundeck-config-custom.properties
fi

FRAMEWORK_SRC=/home/rundeck/custom/framework/framework-append.properties
if test -f "$FRAMEWORK_SRC"; then
    echo "Applying custom framework.properties"
    # see https://docs.rundeck.com/docs/administration/configuration/docker/extending-configuration.html#special-destination-directories
    mkdir -p /tmp/remco-partials/framework
    cp "$FRAMEWORK_SRC" /tmp/remco-partials/framework/framework-custom.properties
fi

if test -d /mnt/plugins; then
    echo "Copying custom plugins"
    cp -r /mnt/plugins/. /home/rundeck/libext
else
    echo "Starting without custom plugins because mount point '/mnt/plugins' does not exist"
fi

echo "Continue with common bootstrap"
exec /home/rundeck/docker-lib/entry.sh
