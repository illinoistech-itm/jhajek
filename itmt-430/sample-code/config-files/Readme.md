# Config-Files

This directory includes three samples pieces of code - these may or may not be needed in your application and are here as demos

## cnf.sh

This file show how from the commandline to create a ```.my.cnf``` file and via ```sed``` populate that configuration file with a default username and password, which allows MySQL/MariaDB authentication and actions to happen without a password prompt.

[https://dev.mysql.com/doc/refman/8.0/en/option-files.html](https://dev.mysql.com/doc/refman/8.0/en/option-files.html "MySQL option files link")

There is a default chart of cascading options for configuration files to be loaded:

| File Name | Purpose |
|-----------|---------|
| /etc/my.cnf | Global options |
| /etc/mysql/my.cnf | Global options |
| SYSCONFDIR/my.cnf | Global options |
| $MYSQL_HOME/my.cnf | Server-specific options (server only) |
| defaults-extra-file | The file specified with --defaults-extra-file, if any |
| ~/.my.cnf	| User-specific options |
| ~/.mylogin.cnf | User-specific login path options (clients only) |
| DATADIR/mysqld-auto.cnf | System variables persisted with SET PERSIST or SE PERSIST_ONLY (server only) |

## db.sh

This shows how to append a multiline string to a MySQL configuration file

## ssl-params.conf

This configuration file can be copied and overwrite your default ssl-params.conf file to harden your SSL/SSH settings
