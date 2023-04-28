-- Run this script to create the right tables for mundus-ts 
-- NOTE: This script will only work for MYSQL
CREATE TABLE Users(username longtext, created datetime, last_modified datetime, user_id serial primary key);

CREATE TABLE UserStatus (status longtext, created datetime, last_modified datetime, user_id int, record_id int auto_increment primary key);

CREATE TABLE UserInfo (url longtext, type longtext, created datetime, last_modified datetime, user_id int, entry_id int serial primary key);
