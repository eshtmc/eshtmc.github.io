#!/bin/bash

DIR=`dirname $0`

TERM="2018.10-2019.03"
NAME="$1"
LIST=${DIR}/../../../education/meetings/${TERM}/speakers.md
TEMP=/tmp/meetings

if cat ${LIST} | grep "${NAME}" &> /dev/null; then
        SPEECHES=`grep -n "${NAME}" ${LIST} | awk -F ':' '{print $1}'`
        MEETINGS=`grep -n "\#\#\#" ${LIST} | awk -F ':' '{print $1}'`
        echo "$MEETINGS" > ${TEMP}
        cat ${LIST} | wc -l >> ${TEMP}
        MEETINGS=`cat ${TEMP}`

        echo "$SPEECHES" | while read SPEECH;
        do
                echo "$MEETINGS" | while read MEETING;
                do
                        if [ $SPEECH -lt $MEETING ]; then
                                MEETING_INFO=`sed -n ${TIME}p ${LIST}`
                                SPEECH_INFO=`sed -n ${SPEECH}p ${LIST} | awk '{print $1}'`
                                echo "  ${SPEECH_INFO} in Meeting ${MEETING_INFO:4}"
                                break
                        fi
                        TIME=${MEETING}
                done
        done

        rm -f ${TEMP}
fi

