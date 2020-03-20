#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
cd ..

if [ "${OSTYPE//[0-9.]/}" == "darwin" ]
then
	PLATFORM="mac"
else
	PLATFORM="linux"
fi

CLASSPATH=$(JARS=("$(pwd)/libs"/*.jar "$(pwd)/jfx/$PLATFORM/"*.jar); IFS=:; echo "${JARS[*]}")
JPROCLASSPATH=$(JARS=("$(pwd)/jprolibs"/*.jar); IFS=:; echo "${JARS[*]}")
JPRO_ARGS=("-Djpro.applications.default=zelosin.pack.base.Main" "-Dprism.useFontConfig=false" "-Djpro.forceShutdown=true" "-Dhttp.port=8080" "-Dquantum.norenderjobs=true" "-Dglass.platform=Monocle" "-Dmonocle.platform=Headless" "-Dprism.fontdir=fonts/" "-Djpro.deployment=MAVEN-Distribution") 



nohup java "${JPRO_ARGS[@]}" "-Djprocp=$JPROCLASSPATH" "$@" -cp "$CLASSPATH"  com.jpro.boot.JProBoot &