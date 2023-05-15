DELIMITER //
/**************************************
* 
*   Author: Antonio Ponce  (13/05/23)
*   Purpose: Create a new user in the database
*   Note: This is a mySQL script. Will need to be translated for use elsewhere...
*
*   ChangeLog:
*   --Name----------------Date---------------------Description----------
**************************************/ 

CREATE PROCEDURE CreateNewUser(IN UserName VARCHAR(255))
BEGIN 

    SET @UserGuid = UUID(); 
    SET @CreatedDate = NOW();
    SET @LastModified = NOW();

    INSERT INTO Users(username, created, last_modified, user_guid) VALUES (UserName, @CreatedDate, @LastModified, @UserGuid);

END 
//