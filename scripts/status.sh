#!/bin/bash

PERSON="$1"
if [ -z $2 ]; then
   TERM="2021.04-2021.09"
else
   TERM="$2"
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
                                echo "${SPEECH_INFO} in Meeting ${MEETING_INFO:4}   "
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
                                echo "${ROLE_INFO} in Meeting ${MEETING_INFO:4}   "
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

   if [ -f ${CLUB_MEETINGS}/attendance.md ]; then
      if grep "${NAME}" ${CLUB_MEETINGS}/attendance.md &> /dev/null; then
         ATTENDANCE=`grep "${NAME}" ${CLUB_MEETINGS}/attendance.md | awk -F"1" '{print NF-1}'`
      else
         ATTENDANCE=0
      fi
      echo "* Attendance:     ${ATTENDANCE}"
   fi

   SPEECHES=`grep "${NAME}" ${CLUB_MEETINGS}/speakers.md | wc -l`
   echo "* Speeches:       ${SPEECHES}"

   ROLES=`grep "${NAME}" ${CLUB_MEETINGS}/role-takers.md | awk -v FS='\`' '{print $2}'`
   BASIC_ROLE_LIST=("Timer" "Ah-counter" "Grammarian" "SAA-helper")
   ADVANCED_ROLE_LIST=("TMD" "TTM" "IE" "GE" "Meeting-Manager")

   #echo "All roles: "${ROLES}""
   if [ -n "${ROLES}" ];then
	   TOTAL_ROLE=`echo "${ROLES}" | wc -l`
	   echo "* Total Roles:    ${TOTAL_ROLE}"
   else
       echo "* Total Roles:    0"
   fi
   
   basicRoleCount=0
   echo "* Bacis Roles:    "
   for basicRole in ${BASIC_ROLE_LIST[@]}
   do
     result=`echo "${ROLES}" | grep -wi "^${basicRole}$" | wc -l`
     echo "    - ${basicRole}: ${result}"
	 let basicRoleCount+=${result}
   done
   echo "    - total:      ${basicRoleCount}"

   advancedRoleCount=0
   echo "* Advanced Roles:    "
   for advancedRole in ${ADVANCED_ROLE_LIST[@]}
   do
     result=`echo "${ROLES}" | grep -wi "^${advancedRole}$" | wc -l`
	 echo "    - ${advancedRole}: ${result}"
	 let advancedRoleCount+=${result}
   done
   echo "    - total:      ${advancedRoleCount}"

}

echo "#### "${PERSON}""
speeches "${PERSON}"
echo ""
roles "${PERSON}"
echo ""
times "${PERSON}"
echo ""
