-- This is a SQL command that creates a non-root user for a MySQL database
-- https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html
GRANT SELECT,INSERT, CREATE, UPDATE, DELETE, DROP ON employees.* TO worker@'localhost' IDENTIFIED BY 'cluster'; flush privileges;