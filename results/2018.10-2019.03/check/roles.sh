#!/bin/bash

DIR=`dirname $0`

TERM="2018.10-2019.03"
NAME="$1"
LIST=${DIR}/../../../education/meetings/${TERM}/role-takers.md
TEMP=/tmp/meetings

if cat ${LIST} | grep "${NAME}"&>/dev/null; then
        ROLES=`grep -n "${NAME}" ${LIST} | awk -F ':' '{print $1}'`
        MEETINGS=`grep -n "\#\#\#" ${LIST} | awk -F ':' '{print $1}'`
        echo "$MEETINGS" > ${TEMP}
        LINES=`cat ${LIST} | wc -l`
        expr $LINES + 1 >> ${TEMP}
        MEETINGS=`cat ${TEMP}`

        echo "$ROLES" | while read ROLE;
        do
                echo "$MEETINGS" | while read MEETING;
                do
                        if [ $ROLE -lt $MEETING ]; then
                                MEETING_INFO=`sed -n ${TIME}p ${LIST}`
                                ROLE_INFO=`sed -n ${ROLE}p ${LIST} | awk '{print $1}'`
                                echo "  ${ROLE_INFO} in Meeting ${MEETING_INFO:4}"
                                break
                        fi
                        TIME=${MEETING}
                done
        done

        rm -f ${TEMP}
fi

