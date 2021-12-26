#!/bin/bash

# Script scans s3 bucket for files matching arguments $1 and $2
# Prints the files details and copy them to destination path or s3 bucket
# Recieves 2 mandatory and 1 optional arguments:
#	age of the searched files, days: int
#	'lesson' tag value of the file:  int
#	destination path or s3 bucket:   str

man_msg="Execution failed! At least 2 arguments required to run script:
        \n\t1: age of files (how many days ago it was uploaded): \t int
        \n\t2: the files 'lesson' tag value: \t\t\t int
        \n\t3: (not necessary) - destination path or s3 bucket: \t str"

if (( $# < 2)); then
    echo -e $man_msg
    exit 1
fi

destination_bucket=${3:-'s3://anddevops.gumerov'}
source_bucket='s3://myfiles.forlesson10'

lines=$(aws s3 ls $source_bucket --recursive | sort -t" " -k1,2);

while read oneline
do
  line_date=$(date --utc -d "$(echo $oneline | cut -d" " -f1,2)" +"%Y-%m-%d %H:%M:%S")
  cond_date=$(date --utc -d "$date $1 days ago" +"%Y-%m-%d %H:%M:%S")
  s3_file_path=$(echo $oneline | cut -d" " -f4)
  if [[ $line_date < $cond_date ]];
  then
    lesson=$(( $(aws s3api get-object-tagging \
      --bucket ${source_bucket:5} \
      --key $s3_file_path \
      --query "TagSet[?Key=='lesson'].Value" \
      --output text 2>/dev/null) + 0))
    if [ "$lesson" -eq "$2" ]
    then
      echo $line_date $s3_file_path "lesson: " $lesson && (aws s3 cp $source_bucket/$s3_file_path $destination_bucket) 
    fi
  fi
done <<< $lines

