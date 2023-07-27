#!/bin/bash

cd ../../.workflows/
regex="^.*\.Dockerfile$"

for file in *; do
	if [ -f "$file" ] && [[ "$file" =~ $regex ]]; then
		touch wf_id.txt
		mkdir logs
		docker build --iidfile wf_id.txt --build-arg REFNAME=$1 --build-arg OLDREV=$2 --build-arg NEWREV=$3 -f "$file" `dirname "$file"` |& tee "logs/${file}_`date`.log"
		if [ $? == 0 ]; then
			docker rmi `cat wf_id.txt`
			continue

		else
			exit $?
		fi
	fi
done
