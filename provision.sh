#!/bin/bash

SCRIPTS_BASE='/tmp/scripts'

chmod +x ${SCRIPTS_BASE}/*.sh

echo "==> Running configuration scripts"
for script in $( ls -1 ${SCRIPTS_BASE}/*.sh )
do
    echo "==> Running ${script}"
    ${script}
done

echo "==> The configuration has finished!"
