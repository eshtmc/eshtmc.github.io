#!/bin/bash

for TERM in ../education/meetings/*; do TERM=`basename $TERM`; ./report.sh $TERM > ../membership/members/$TERM/report.md; done
