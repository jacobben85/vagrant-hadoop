#!/bin/sh -e

export JAVA_HOME="/usr/lib/jvm/java-8-oracle"

echo "Added JAVA_HOME"

/usr/local/hadoop/sbin/start-all.sh
