-- Run this script to create the right tables for mundus-ts 
-- NOTE: This script will only work for MYSQL | Would need to be adjusted for another flavor of SQL
CREATE TABLE Users(username longtext, created datetime, last_modified datetime, user_guid char(38), id int auto_increment primary key);

CREATE TABLE UserStatus (status longtext, created datetime, last_modified datetime, user_guid char(38), id int auto_increment primary key);

CREATE TABLE UserInfo (url longtext, type longtext, created datetime, last_modified datetime, user_guid char(38), id int auto_increment primary key);
