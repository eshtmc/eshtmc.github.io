#!/bin/bash

if [ -z $1 ]; then
   TERM="2018.10-2019.03"
else
   TERM="$1"
fi

DIR=`dirname $0`
CLUB_MEETINGS=${DIR}/../education/meetings/${TERM}
CLUB_MEMBERS=${DIR}/../membership/members/${TERM}

function speeches {
   NAME="$1"
   LIST=${CLUB_MEETINGS}/speakers.md
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
                                echo "${SPEECH_INFO} in Meeting ${MEETING_INFO:4}"
                                echo ""
                                break
                        fi
                        TIME=${MEETING}
                done
        done

        rm -f ${TEMP}
   fi
}

function roles {
   NAME="$1"
   LIST=${CLUB_MEETINGS}/role-takers.md
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
                                echo "${ROLE_INFO} in Meeting ${MEETING_INFO:4}"
                                echo ""
                                break
                        fi
                        TIME=${MEETING}
                done
        done

        rm -f ${TEMP}
   fi
}

function times {
   NAME="$1"

   SPEECHES=`grep "${NAME}" ${CLUB_MEETINGS}/speakers.md | wc -l`
   ROLES=`grep "${NAME}" ${CLUB_MEETINGS}/role-takers.md | wc -l`

   echo "* Speeches: ${SPEECHES}"
   echo "* Roles: ${ROLES}"
}

TIME_STAMP=`date "+%Y-%m-%d"`
MEMBER_LIST=`grep \#\#\#\#\# ${CLUB_MEMBERS}/list.md | awk '{print $2,$3}' | sort -d`
echo "${MEMBER_LIST}" | while read PERSON;
do
        echo "##### "${PERSON}""
        speeches "${PERSON}"
        roles "${PERSON}"
        echo ""
        times "${PERSON}"
        echo ""
done
