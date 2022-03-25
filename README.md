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
inactive and invalid IPs, named ``reachability_test.txt``. Run script using ``./ping_sweeper.sh <filename>``
where <filename> is the path to file with the IPs.

🔗 [ping_sweeper.sh](ping_sweeper.sh)

## Port scanner

There are two ways of running port scanner script:

``port_scanner.sh -n <port> -h <host_file>``

``port_scanner.sh -f <port_file> -h <host_file>``

* ``port`` - Port number, an integer between 0 and 65535.
* ``port_file`` - File with the list of ports.
* ``host_file`` - File list with host names.

The output will a list with the active, inactive and invalid ports, based on result,
and it will be stored in ``scan_report.txt`` file.

🔗 [port_scanner.sh](port_scanner.sh)

## Git Backup

More details: 🔗 [git_backups](git_backups)
