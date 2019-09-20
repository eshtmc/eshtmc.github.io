#!/bin/bash

DIR=`dirname $0`

if [ -z $1 ]; then
   TERM="2019.04-2019.09"
else
   TERM="$1"
fi

CLUB_MEETINGS=${DIR}/../education/meetings/${TERM}
CLUB_MEMBERS=${DIR}/../membership/members/${TERM}

MEMBER_LIST=`grep \#\#\#\#\# ${CLUB_MEMBERS}/list.md | awk '{print $2,$3}' | sort -d`
echo "${MEMBER_LIST}" | while read PERSON;
do
   ${DIR}/status.sh "${PERSON}" "${TERM}"
done
