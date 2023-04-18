/**************************************
* 
*   Author: Antonio Ponce  (06/04/23)
*   Purpose: Migrate old data from SQlite3 table 'Userlib' to appropriate tables in MySQL 
*
*   ChangeLog:
*   --Name----------------Date---------------------Description----------
*
*
**************************************/ 

CREATE TYPE [dbo].[ImportData] AS TABLE(
    Id int NOT NULL, 
    UserName varchar(255) NOT NULL, 
    GitHub varchar(255) NULL, 
    LinkedIn varchar(255) NULL, 
    Website varchar(255) NULL, 
    [Status] varchar(255) NULL 
)

CREATE PROCEDURE [MigrateOldRecordsFrom_Userlib]
    @Userlib ImportData READONLY 
AS
BEGIN 
    SET NOCOUNT ON 

    -- Schema for old data
    -- Userlib(ID int, UserName varchar(255), Url1 varchar(255), 
    -- Url2 varchar(255), Url3 varchar(255), Status varchar(255), level int)
    -- When exporting old data, make sure to distingush between urls
    -- that is, when writing export query, return as GitHub, linkedin, and website respectively
    -- distinctions | 'github': 'Url1', 'linkedin': 'Url2', 'website': 'Url3'

    DECLARE @CreatedDate as DATETIME, @LastModified as DATETIME;
    DECLARE @Counter INT, @Max INT; 

    -- Id needs to come as a int, so assign it in the for loop for virtual datatable object...
    SELECT @Counter = MIN(Id), @Max = MAX(Id) FROM @Userlib;

    SET @CreatedDate = now();
    SET @LastModified = now();

    -- This logic runs for each user found in the import data 
    
    WHILE @Counter <= @Max 
    BEGIN 

        DECLARE UserId INT, 
        @Github Varchar(MAX), 
        @LinkedIn Varchar(MAX), 
        @Website VARCHAR(MAX), 
        @Status VARCHAR(MAX); 

        -- Grab this specific user's data...
        SELECT 
            @UserId = Id, 
            @GitHub = Github,
            @LinkedIn = LinkedIn,
            @Website = Website,
            @Status = [Status]
        FROM 
            @Userlib 
        WHERE 
            Id = @Counter; 

        -- Update initial user date into Users table 
        INSERT INTO Users (Username, Created, LastModified) 
            VALUES (@Username, @CreatedDate, @LastModified);

        -- Get auto generated Userid
        SET @UserId = SELECT UserId from Users where Username = @Username;

        -- Insert into UserInfo, 3 inserts here! (website, github, linkedin)
        IF (@GitHub <> NULL)
        BEGIN 
            INSERT INTO UserInfo (Url, Type, Created, LastModified, UserId) 
                VALUES (@GitHub, 'GitHub', @CreatedDate, @LastModified, @UserId);
        END 

        IF (@LinkedIn <> NULL)  
        BEGIN        
            INSERT INTO UserInfo (Url, Type, Created, LastModified, UserId) 
                VALUES (@LinkedIn, 'LinkedIn', @CreatedDate, @LastModified, @UserId);
        END 

        IF (@Website <> NULL)
        BEGIN 
            INSERT INTO UserInfo (Url, Type, Created, LastModified, UserId) 
                VALUES (@Website, 'Website', @CreatedDate, @LastModified, @UserId);
        END
        -- Insert into UserStatus 
        INSERT INTO UserStatus (Status, Created, LastModified, UserId)
            VALUES (@Status, @CreatedDate, @LastModified, @UserId);


        SET @Counter = @Counter + 1; 

    END 
END 
GO