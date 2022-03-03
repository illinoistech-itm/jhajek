-- Insert Data into Assignment05
USE Assignment05;

INSERT INTO temperatures (id, temperature) Values (0,'[35, 36, 32, 30, 40, 42, 38]');
INSERT INTO temperatures (id, temperature) Values (0,'[31, 32, 34, 55, 56]');

-- Insert Data into Assignment05b
USE Assignment05b;

INSERT INTO temperatures (id, temperature) Values (0,'[21, 26, 44, 8, 20, 42, 38]');
INSERT INTO temperatures (id, temperature) Values (0,'[28, 22, 30, 52, 58]');

-- grant access to Assignment05 and b table
GRANT SELECT,INSERT, CREATE, UPDATE, DELETE, DROP ON Assignment05.* TO worker@'localhost' IDENTIFIED BY 'cluster'; flush privileges;
GRANT SELECT,INSERT, CREATE, UPDATE, DELETE, DROP ON Assignment05b.* TO worker@'localhost' IDENTIFIED BY 'cluster'; flush privileges;