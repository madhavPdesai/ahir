#!/bin/bash
echo -n "char commit_version_string[] = \"" > commit_strings.h
VAR=$(git log -n 1 | grep "commit") 
echo -n $VAR >> commit_strings.h
echo  "\";" >> commit_strings.h
echo -n "char commit_date_string[] = \"" >> commit_strings.h
DVAR=$(git log -n 1 | grep "Date") 
echo -n $DVAR >> commit_strings.h
echo  "\";" >> commit_strings.h

