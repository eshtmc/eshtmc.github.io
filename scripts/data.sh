#!/bin/bash

for TERM in ../education/meetings/*; do TERM=`basename $TERM`; ./status.sh $TERM > ../membership/members/$TERM/report.md; done
