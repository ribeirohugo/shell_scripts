#!/bin/bash

file_passwd="/etc/passwd"
file_shadow="/etc/shadow"
file_group="/etc/group"
file_error="/tmp/auth_errors"

while IFS=: read -r user_name user_pass user_id groupid comment homedir cmdshell
do
	# Check if user has encrypted password
	has_shadow="false"

	while IFS=: read -r user pass lastpass min max warn inactive expire
	do
		if [ "$user_name" = "$user" ]; then
			has_shadow="true"

			break
		fi;
	done < $file_shadow

	# Check if group exists
	group_exists="false"

	while IFS=: read -r group_name group_password group_id group_list
	do
		if [ "$group_id" = "$groupid" ]; then
			group_exists="true"

			break
		fi;
	done < $file_group

	# Log that if user doesn't have encrypted password
	if [ "$has_shadow" = "false" ] ; then
		echo "User $user has no encrypted password. \n" >> $file_error
	fi

	# Log that if group doesn't exists
	if [ "$group_exists" = "false" ] ; then
		echo "User $user group doesn't exist. \n" >> $file_error
	fi

	# Check if homedir exists
	if [ -d  "$homedir" ]; then
		dir_owner=`stat -c "%U" "$homedir"`
		if [ "$user" != "$dir_owner" ]; then
			echo "homedir $user user doesn't match with owner $dir_owner \n" >> $file_error
		fi

		dir_group=`stat -c "%G" "$homedir"`
		if [ "$groupid" != "$dir_group" ]; then
			echo "homedir $groupid group doesn't match with owner $dir_group \n" >> $file_error
		fi

	else
		echo "homedir doesn't exist: $homedir \n" >> $file_error
	fi

done < $file_passwd
