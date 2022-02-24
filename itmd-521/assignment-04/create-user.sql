-- This is a SQL command that creates a non-root user for a MySQL database

GRANT SELECT,INSERT,UPDATE, DELETE ON employees.* TO worker@'localhost' IDENTIFIED BY 'cluster'; flush privileges;