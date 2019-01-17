#!/bin/bash

DIR=`dirname $0`
TIMESTAMP=`date "+%Y-%m-%d"`
TERM="2018.10-2019.03"
MEMBERS=`grep \#\#\#\#\# ${DIR}/../../education/meetings/${TERM}/status.md | awk '{print $2,$3}' | sort -d`

echo "#Status"
echo "#### Reimbursement Condition"

echo "${MEMBERS}" | while read PERSON;
do
        echo "##### "${PERSON}""
        ${DIR}/check/speeches.sh "${PERSON}"
        ${DIR}/check/roles.sh "${PERSON}"
        echo ""
        ${DIR}/check/times.sh "${PERSON}"
        echo ""
done

