DELIMITER //
/**************************************
* 
*   Author: Antonio Ponce  (06/04/23)
*   Purpose: Return UserData associated with a Username  
*   Note: This is a mySQL script. Will need to be translated for use elsewhere...
*
*   ChangeLog:
*   --Name----------------Date---------------------Description----------
*   Antonio Ponce         (03/05/23)               Changed proc to be a stand-alone insert
*   Antonio Ponce         (11/05/23)               Simplied SELECT
**************************************/ 

CREATE PROCEDURE GetUserInfo(IN UserName VARCHAR(255))
BEGIN 

    SELECT 
        ui.url, 
        ui.type 
    FROM UserInfo ui 
    JOIN Users u 
        ON u.user_guid = ui.user_guid 
    WHERE u.username = UserName; 

END 
//