#!/bin/bash

PERSON="$1"
if [ -z $2 ]; then
   TERM="2019.10-2020.03"
else
   TERM="$2"
fi

DIR=`dirname $0`
CLUB_MEETINGS=${DIR}/../education/meetings/${TERM}
CLUB_MEMBERS=${DIR}/../membership/members/${TERM}

function speeches {
   NAME="$1"
   LIST=${CLUB_MEETINGS}/speakers.md

   if cat ${LIST} | grep "${NAME}" &> /dev/null; then
        SPEECHES=`grep "${NAME}" ${LIST} | wc -l`
        echo ${SPEECHES}
   else
        echo 0
   fi
}

function roles {
   NAME="$1"
   LIST=${CLUB_MEETINGS}/role-takers.md

   if cat ${LIST} | grep "${NAME}"&>/dev/null; then
        ROLES=`grep "${NAME}" ${LIST} | wc -l`
        echo ${ROLES}
   else
        echo 0
   fi
}

function basic_roles {
   NAME="$1"
   LIST=${CLUB_MEETINGS}/role-takers.md
   BASIC_ROLE_LIST=("TIMER" "ah-counter" "grammarian" "SAA-helper")

   if cat ${LIST} | grep "${NAME}"&>/dev/null; then
        ROLES=`grep "${NAME}" ${LIST} | awk -v FS='\`' '{print $2}'`
		basicRoleCount=0
		for basicRole in ${BASIC_ROLE_LIST[@]}
		do
		 result=`echo "${ROLES}" | grep -wi "^${basicRole}$" | wc -l`
		 let basicRoleCount+=${result}
		done
        echo ${basicRoleCount}
   else
        echo 0
   fi
}

function advanced_roles {
   NAME="$1"
   LIST=${CLUB_MEETINGS}/role-takers.md
   ADVANCED_ROLE_LIST=("TMD" "TTM" "IE" "GE" "TTE" "Meeting-Manager")

   if cat ${LIST} | grep "${NAME}"&>/dev/null; then
        ROLES=`grep "${NAME}" ${LIST} | awk -v FS='\`' '{print $2}'`
		advancedRoleCount=0
		for advancedRole in ${ADVANCED_ROLE_LIST[@]}
		do
		 result=`echo "${ROLES}" | grep -wi "^${advancedRole}$" | wc -l`
		 let advancedRoleCount+=${result}
		done
        echo ${advancedRoleCount}
   else
        echo 0
   fi
}

function times {
   NAME="$1"

   if [ -f ${CLUB_MEETINGS}/attendance.html ]; then
      if grep "${NAME}" ${CLUB_MEETINGS}/attendance.html &> /dev/null; then
         ATTENDANCE=`grep "${NAME}" ${CLUB_MEETINGS}/attendance.html | awk -F"1" '{print NF-1}'`
      else
         ATTENDANCE=0
      fi
      echo ${ATTENDANCE}
   fi
}

SPEECHES=`speeches "${PERSON}"`
ROLES=`roles "${PERSON}"`
TIMES=`times "${PERSON}"`
BASIC_ROLES=`basic_roles "${PERSON}"`
ADVANCED_ROLES=`advanced_roles "${PERSON}"`
echo "${PERSON} ${TIMES} ${SPEECHES} ${ROLES} ${BASIC_ROLES} ${ADVANCED_ROLES}"
