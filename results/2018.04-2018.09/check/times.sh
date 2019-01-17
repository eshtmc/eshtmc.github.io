#!/bin/bash

DIR=`dirname $0`

TERM="2018.04-2018.09"
NAME="$1"

SPEECHES=`grep "${NAME}" ${DIR}/../../../education/meetings/${TERM}/speakers.md | wc -l`
ROLES=`grep "${NAME}" ${DIR}/../../../education/meetings/${TERM}/role-takers.md | wc -l`

echo "* Speeches: ${SPEECHES}"
echo "* Roles: ${ROLES}"
