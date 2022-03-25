#!/bin/bash

file_repo="repos.txt"
output_file="backups"

printf "Git Backup started\n\n"

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
