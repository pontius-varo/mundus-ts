DELIMITER //
/**************************************
* 
*   Author: Antonio Ponce  (06/04/23)
*   Purpose: Migrate old data from SQlite3 table 'Userlib' to appropriate tables in MySQL 
*   Note: This is a mySQL script. Will need to be translated for use elsewhere...
*
*   ChangeLog:
*   --Name----------------Date---------------------Description----------
*   Antonio Ponce         (27/04/23)               Changed proc to be a stand-alone insert
*
**************************************/ 

CREATE PROCEDURE MigrateUserData(
    IN UserName VARCHAR(255), 
    IN GitHub VARCHAR(255), 
    IN LinkedIn VARCHAR(255), 
    IN Website VARCHAR(255), 
    IN Status VARCHAR(255))
BEGIN 

    SET @CreatedDate = NOW();
    SET @LastModified = NOW();
    
    -- Update initial user date into Users table 
    INSERT INTO Users (username, created, last_modified) VALUES (Username, @CreatedDate, @LastModified);
    -- Get auto generated Userid
    SELECT user_id FROM Users WHERE username = Username INTO @UserId; 

    -- Insert into UserInfo, 3 inserts here<> (website, github, linkedin)
    IF GitHub <> '' THEN INSERT INTO UserInfo (url, type, created, last_modified, user_id) VALUES (GitHub, 'GitHub', @CreatedDate, @LastModified, @UserId);
    END IF;  

    IF LinkedIn <> '' THEN INSERT INTO UserInfo (url, type, created, last_modified, user_id) VALUES (LinkedIn, 'LinkedIn', @CreatedDate, @LastModified, @UserId);
    END IF;  

    IF Website <> '' THEN INSERT INTO UserInfo (url, type, created, last_modified, user_id) VALUES (Website, 'Website', @CreatedDate, @LastModified, @UserId);
    END IF; 
     
    INSERT INTO UserStatus (status, created, last_modified, user_id) VALUES (Status, @CreatedDate, @LastModified, @UserId); 
END 
//