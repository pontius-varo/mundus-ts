-- Run this script to create the right tables for mundus-ts
CREATE TABLE Users(username longtext, created datetime, last_modified datetime, user_id serial primary key);

CREATE TABLE UserStatus (status longtext, last_modified datetime, user_id int primary key);

CREATE TABLE UserInfo (url longtext, type longtext, created datetime, last_modified datetime, user_id int primary key);
