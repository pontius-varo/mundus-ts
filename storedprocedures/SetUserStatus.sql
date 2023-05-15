DELIMITER //
/**************************************
* 
*   Author: Antonio Ponce  (14/05/23)
*   Purpose: Set user's status in UserStatus
*   Note: This is a mySQL script. Will need to be translated for use elsewhere...
*
*   ChangeLog:
*   --Name----------------Date---------------------Description----------
**************************************/ 

CREATE PROCEDURE SetUserStatus(IN UserName VARCHAR(255), IN NewStatus VARCHAR(255))
BEGIN 

    -- Might as well grab the Userguid, just in case...
    SELECT u.user_guid FROM Users WHERE u.username = UserName INTO @UserGuid; 

    SELECT us.id FROM UserStatus us WHERE us.user_guid = @UserGuid INTO @StatusId;

    IF @StatusId IS NULL THEN INSERT INTO UserStatus (status, created, last_modified, user_guid) VALUES (NewStatus, NOW(), NOW(), @UserGuid);
    ELSE UPDATE UserStatus us SET us.status = NewStatus, us.last_modified = NOW() WHERE us.id = @StatusId;
    END IF;   

END 
//