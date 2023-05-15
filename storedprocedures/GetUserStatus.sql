DELIMITER //
/**************************************
* 
*   Author: Antonio Ponce  (14/05/23)
*   Purpose: Return UserStatus
*   Note: This is a mySQL script. Will need to be translated for use elsewhere...
*
*   ChangeLog:
*   --Name----------------Date---------------------Description----------
**************************************/ 

CREATE PROCEDURE GetUserStatus(IN UserName VARCHAR(255))
BEGIN 
    SELECT 
        us.status 
    FROM UserStatus us
    JOIN Users u 
        ON u.user_guid = us.user_guid
    WHERE 
        u.username = UserName;
END 
//