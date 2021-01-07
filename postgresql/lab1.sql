
--LAB1A

--LAB1Part1

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);


CREATE TABLE status (
    id SERIAL PRIMARY KEY,
    description VARCHAR(12) NOT NULL
        CHECK (description IN ('Available', 'Checked Out', 'Overdue', 'Unavailable', 'Under Repair')),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);



CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    status_id SERIAL REFERENCES status,
    description VARCHAR(12) NOT NULL
        CHECK (description in ('Laptop1', 'Laptop2', 'Webcam1', 'TV1', 'Microphone1')),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);


CREATE TABLE transactions(
    id SERIAL PRIMARY KEY,
    user_id SERIAL REFERENCES users,
    inventory_id SERIAL REFERENCES inventory,
    checkout_time TIMESTAMP NOT NULL,
    scheduled_checkin_time TIMESTAMP,
    actual_checkin_time TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);




--Insert 5 users into the users table.


INSERT INTO users (id, first_name, last_name, email, password, created_at, updated_at) VALUES (1, 'Ozge', 'Altas', 'oerol2@uis.edu', 'panda', '2020-08-28 21:16:17.184746', NULL);
INSERT INTO users (id, first_name, last_name, email, password, created_at, updated_at) VALUES (2, 'Huseyin', 'Altas', 'hsyn1@uis.edu', 'kitty', '2020-08-28 21:17:10.729841', NULL);
INSERT INTO users (id, first_name, last_name, email, password, created_at, updated_at) VALUES (3, 'Lily', 'Ben', 'blily3@uis.edu', 'purple', '2020-08-28 21:17:16.140226', NULL);
INSERT INTO users (id, first_name, last_name, email, password, created_at, updated_at) VALUES (4, 'Summer', 'Miles', 'smiles@uis.edu', 'ocean', '2020-08-28 21:17:41.368481', NULL);
INSERT INTO users (id, first_name, last_name, email, password, created_at, updated_at) VALUES (5, 'Jacob', 'Parker', 'pjacob@uis.edu', 'basketball', '2020-08-28 21:17:55.449424', NULL);


--Insert 5 records into the status table. The description field should be:  Available, Checked out, Overdue, Unavailable, Under Repair. 


INSERT INTO status (id, description, created_at, updated_at) VALUES (5, 'Available', NULL, NULL);
INSERT INTO status (id, description, created_at, updated_at) VALUES (7, 'Checked Out', NULL, NULL);
INSERT INTO status (id, description, created_at, updated_at) VALUES (8, 'Overdue', NULL, NULL);
INSERT INTO status (id, description, created_at, updated_at) VALUES (9, 'Unavailable', NULL, NULL);
INSERT INTO status (id, description, created_at, updated_at) VALUES (10, 'Under Repair', NULL, NULL);


--Insert 5 records into the inventory table. The description field should be: Laptop1, Laptop2, Webcam1, TV1, Microphone1. 


INSERT INTO inventory (id, status_id, description, created_at, updated_at) VALUES (2, 5, 'Laptop1', NULL, NULL);
INSERT INTO inventory (id, status_id, description, created_at, updated_at) VALUES (3, 10, 'Laptop2', NULL, NULL);
INSERT INTO inventory (id, status_id, description, created_at, updated_at) VALUES (6, 7, 'Webcam1', NULL, NULL);
INSERT INTO inventory (id, status_id, description, created_at, updated_at) VALUES (7, 8, 'TV1', NULL, NULL);
INSERT INTO inventory (id, status_id, description, created_at, updated_at) VALUES (8, 9, 'Microphone1', NULL, NULL);


--Insert 3 records into the transactions table. Then update the status of these three inventory items in the inventory table to Checked out. 



INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (1, 1, 2, '2020-08-28 22:41:26.626938', '2020-06-24 12:23:42', '2020-06-25 13:42:06', NULL, NULL);
INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (2, 2, 3, '2020-08-28 22:42:03.307922', '2020-03-21 12:23:42', '2020-03-22 13:42:06', NULL, NULL);
INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (3, 3, 7, '2020-08-28 22:43:40.029229', '2020-09-23 12:30:42', '2020-09-25 13:42:06', NULL, NULL);
INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (4, 4, 8, '2020-08-28 23:07:07.290181', '2020-08-01 10:10:57', '2020-08-02 13:00:43', '2020-08-28 23:07:07.290181', NULL);
INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (5, 5, 6, '2020-08-28 23:12:10.021457', '2020-08-13 10:20:43', '2020-08-14 13:00:43', '2020-08-28 23:12:10.021457', NULL);


--Alter the users table to add a column for signed_agreement (Boolean column that defaults to false).


ALTER TABLE users ADD signed_agreement BOOLEAN DEFAULT FALSE;


--Write a query that returns a list of all the equipment and its scheduled_checkin_time that is checked out ordered by scheduled_checkin_time in descending order.
-- Checked Out status id is 7.


SELECT inventory_id, inventory.description, transactions.scheduled_checkin_time FROM inventory INNER JOIN transactions ON inventory.id = transactions.inventory_id WHERE inventory.status_id = 7 ORDER BY transactions.scheduled_checkin_time DESC;


--Write a query that returns a list of all equipment due after July 31, 2020. 


SELECT inventory_id, inventory.description, transactions.scheduled_checkin_time FROM inventory INNER JOIN transactions ON inventory.id = transactions.inventory_id WHERE transactions.scheduled_checkin_time >= '2020-07-31 23:59:59';


--Write a query that returns a count of the number of items with a status of Checked out by user_id 1.  


SELECT COUNT (*) FROM inventory INNER JOIN transactions ON inventory.id = transactions.inventory_id WHERE transactions.user_id = 1 AND inventory.status_id = 7;




-- Completed on 2020-08-28 18:21:45

--
--LAB1B

--Insert 20 transactions

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at)
VALUES(6, 1, 2, '2018-09-12 12:00:00', '2018-09-03 13:00:00', '2018-09-05 10:00:00', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (7, 2, 2, '2018-09-11 12:00:00', '2018-09-07 13:40:00', '2018-09-10 10:00:00', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (8, 3, 2, '2019-09-11 12:00:00', '2019-09-07 13:40:00', '2019-09-10 10:00:00', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (9, 4, 7, '2020-02-02 14:46:23', '2020-02-02 12:00:00', '2020-02-02 13:45:00', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (10, 5, 3, '2018-03-09 15:45:00', '2018-03-07 17:50:43', '2018-03-08 13:05:00', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (11, 1, 7, '2018-06-09 12:50:43', '2018-06-06 16:16:00', '2018-06-05 12:00:05', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (12, 2, 8, '2016-10-11 15:54:45', '2016-10-05 16:35:45', '2016-10-01 13:23:32', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (13, 3, 2, '2015-12-25 16:54:00', '2015-12-24 14:32:32', '2015-12-23 16:54:43', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (14, 4, 3, '2014-07-08 19:54:43', '2014-06-23 16:00:00', '2014-06-26 19:45:04', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (15, 5, 6, '2018-03-30 18:00:00', '2018-01-30 14:43:43', '2018-02-05 17:45:54', NULL, NULL);
	
INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (16, 1, 7, '2019-03-30 18:00:00', '2019-01-30 14:43:43', '2019-01-31 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (17, 2, 8, '2019-03-30 18:00:00', '2019-02-03 14:43:43', '2019-02-05 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (18, 3, 3, '2020-03-30 18:00:00', '2020-01-30 14:43:43', '2020-02-05 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (19, 4, 6, '2020-04-30 18:00:00', '2020-04-30 14:43:43', '2020-04-05 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (20, 5, 7, '2020-09-05 23:12:22.725347', '2020-04-30 14:43:43', '2020-04-05 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (21, 1, 2, '2020-09-05 23:13:01.924934', '2020-05-07 14:43:43', '2020-05-05 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (22, 1, 2, '2020-09-05 23:13:32.755115', '2020-06-17 14:43:43', '2020-06-15 17:45:54', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (23, 4, 2, '2020-09-05 23:16:49.487322', '2020-09-03 13:54:32', '2020-09-04 12:30:00', NULL, NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (24, 4, 3, '2020-09-05 23:36:28.892222', '2020-08-08 18:54:43', '2020-08-09 15:43:54', '2020-09-05 23:36:28.892222', NULL);

INSERT INTO transactions (id, user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at) VALUES (25, 5, 7, '2020-09-05 23:37:04.003709', '2020-08-18 18:54:43', '2020-08-20 15:43:54', '2020-09-05 23:37:04.003709', NULL);


--Create a late checkins view of distinct items that were checked in late grouped by user_id, inventory_id, and description. 

CREATE VIEW checkins AS
SELECT transactions.user_id, transactions.inventory_id, COUNT(transactions.id)
FROM transactions
WHERE (transactions.actual_checkin_time > transactions.scheduled_checkin_time)
GROUP BY transactions.user_id, transactions.inventory_id;

--Displaying all records from the view.

SELECT * FROM checkins;