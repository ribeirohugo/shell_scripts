# Shell scripts

Generic shell scripts repository.

## Check server users

As a Linux server administrator I want to check all users registered
in ``/etc/passwd`` have an entry in ``/etc/shadow``, if the primary group exists, if the
home directory exists and belongs to the correct owner and group. Any non-compliance
should be logged in ``/tmp/auth_errors``.

🔗 [check_server_users.sh](check_server_users.sh)
