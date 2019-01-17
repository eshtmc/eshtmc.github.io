#!/bin/bash

DIR=`dirname $0`

TERM="2018.10-2019.03"
NAME="$1"

SPEECHES=`grep "${NAME}" ${DIR}/../../../education/meetings/${TERM}/speakers.md | wc -l`
ROLES=`grep "${NAME}" ${DIR}/../../../education/meetings/${TERM}/role-takers.md | wc -l`

echo "* Speeches: ${SPEECHES}"
echo "* Roles: ${ROLES}"
