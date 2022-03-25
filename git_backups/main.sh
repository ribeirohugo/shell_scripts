#!/bin/bash

output_file="backups"

file_repo=$1

if [ "$file_repo" == "" ]
then
  file_repo="repos.txt"
fi

printf "Git Backup started\n\n"

printf "Checking dependencies... \n\n"
apt install zip -y

mkdir "$output_file"
printf "File \"%s\" created\n\n" "$output_file"

while IFS="" read -r line || [ -n "$line" ]
do
  git -C "$output_file" clone "$line"
done < $file_repo

current_date="backup_"$(date '+%Y_%m_%d_%H_%M_%S')
zip_filename="$current_date"

zip -r "$zip_filename" "$output_file"
printf "Compressed \"%s\" folder to \"%s\".\n\n" "$output_file" "$zip_filename"

rm -rf "$output_file"
printf "File \"%s\" removed\n\n" "$output_file"

echo "Git Backup ended"
