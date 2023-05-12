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

CREATE PROCEDURE MigrateUserData(IN UserName VARCHAR(255), IN GitHub VARCHAR(255), IN LinkedIn VARCHAR(255), IN Website VARCHAR(255), IN Status VARCHAR(255))
BEGIN 

    -- Use a GUID as user identifier between tables....

    SET @UserGuid = UUID(); 

    SET @CreatedDate = NOW();
    SET @LastModified = NOW();
    
    -- Update initial user date into Users table 
    INSERT INTO Users (username, created, last_modified, user_guid) VALUES (Username, @CreatedDate, @LastModified, @UserGuid);

    -- Insert into UserInfo, 3 inserts here<> (website, github, linkedin)
    IF GitHub <> '' THEN INSERT INTO UserInfo (url, type, created, last_modified, user_guid) VALUES (GitHub, 'GitHub', @CreatedDate, @LastModified, @UserGuid);
    END IF;  

    IF LinkedIn <> '' THEN INSERT INTO UserInfo (url, type, created, last_modified, user_guid) VALUES (LinkedIn, 'LinkedIn', @CreatedDate, @LastModified, @UserGuid);
    END IF;  

    IF Website <> '' THEN INSERT INTO UserInfo (url, type, created, last_modified, user_guid) VALUES (Website, 'Website', @CreatedDate, @LastModified, @UserGuid);
    END IF; 
     
    INSERT INTO UserStatus (status, created, last_modified, user_guid) VALUES (Status, @CreatedDate, @LastModified, @UserGuid); 
END 
//