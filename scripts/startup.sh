#!/bin/sh -e

export JAVA_HOME="/usr/lib/jvm/java-8-oracle"

echo "Added JAVA_HOME"

sudo -H -u vagrant bash -c "/usr/local/hadoop/sbin/start-all.sh"
