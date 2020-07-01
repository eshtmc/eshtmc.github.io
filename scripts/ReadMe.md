#### User Guide for script data.sh
No parameter needed, use to generate report.md file which reports detailed meeting information under all term for all responding members

#### User Guide for script report.sh
One parameter {term} needed，use to output all members detailed meeting information for the specified term.
For example:
./report.sh 2020.04-2020.09

#### User Guide for script report-table.sh
One parameter {term} needed，use to output all members brief meeting information for the specified term.
Output format:  {Member-name} {Attendance} {Speeches times} {Total-Roles times} {Bacis-Roles times} {Advanced-Roles times}
For example:
$ ./report-table.sh 2020.04-2020.09
Bingchen Guo 0 0 0 0 0
Candice Gao 0 2 0 0 0
Chunmiao Liu 1 1 1 0 1

#### User Guide for script status.sh
Two parameters {member-name} {term} needed，use to output the required member's detailed meeting information for the specified term.
For example:
 ./status.sh "Anne Liu" 2020.04-2020.09
 
#### User Guide for script status-table.sh
Two parameters {member-name} {term} needed，use to output required member's brief meeting information for the specified term. 
Output format:  {Member-name} {Attendance} {Speeches times} {Total-Roles times} {Bacis-Roles times} {Advanced-Roles times}
