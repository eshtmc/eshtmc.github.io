#!/bin/bash

DIR=`dirname $0`

if [ -z $1 ]; then
   TERM="2021.04-2021.09"
else
   TERM="$1"
fi

CLUB_MEETINGS=${DIR}/../education/meetings/${TERM}
CLUB_MEMBERS=${DIR}/../membership/members/${TERM}

MEMBER_LIST=`grep \#\#\#\#\# ${CLUB_MEMBERS}/list.md | awk '{print $2,$3}' | sort -d`
echo "${MEMBER_LIST}" | while read PERSON;
do
   ${DIR}/status-table.sh "${PERSON}" "${TERM}"
done
