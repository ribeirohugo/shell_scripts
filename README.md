# Shell scripts

Generic shell scripts repository.

## Check server users

As a Linux server administrator I want to check all users registered
in ``/etc/passwd`` have an entry in ``/etc/shadow``, if the primary group exists, if the
home directory exists and belongs to the correct owner and group. Any non-compliance
should be logged in ``/tmp/auth_errors``.

🔗 [check_server_users.sh](check_server_users.sh)

## Ping sweeper

Iterates over a file divided into lines with IPs in each one and returns a list with the sum of active,
inactive and invalid IPs, named ``reachability_test.txt``. Run script using ``sh ./ping_sweeper <filename>``
where <filename> is the path to file with the IPs.

🔗 [ping_sweeper.sh](ping_sweeper.sh)
