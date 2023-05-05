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
*
**************************************/ 

CREATE PROCEDURE GetUserInfo(
    IN UserName VARCHAR(255)
)
BEGIN 

    SELECT user_id FROM Users WHERE username = Username LIMIT 1 INTO @UserId;

    SELECT 
    ui.url,
    ui.type
    FROM UserInfo ui
    WHERE user_id = @UserId; 
    
END 
//