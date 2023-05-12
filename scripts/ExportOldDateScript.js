import * as dotenv from 'dotenv' 
import Database from 'better-sqlite3';
import mysql from 'mysql2';

dotenv.config()

/* Globals */ 
const sqliteDatabasePath = process.env.SQLITE_DATABASE_PATH;

const poolConfig = {
    host: process.env.SQL_HOST,
    user: process.env.SQL_USER,
    database: process.env.SQL_DATABASE,
    password: process.env.SQL_USER_PASSWORD,
    connectionLimit: 250,
}

var sqlProcQuery = `CALL MigrateUserData(?, ?, ?, ?, ?)`;

/* Functions */ 

function checkIfNone(url){
    return url == 'None' ? '' : url;
}


function getUserDataFromSQLite(db){

    let userData = new Promise((resolve, reject) => {
        
        try {
            let statement = db.prepare('SELECT * FROM Userlib;');

            let data = [];
            
            for(let user of statement.iterate()){

                user.Url1 = checkIfNone(user.Url1);
                user.Url2 = checkIfNone(user.Url2);
                user.Url3 = checkIfNone(user.Url3);

                data.push(user);
            }    
    
            resolve(data);    
        } catch(e) {
            reject(e);
            throw (e);
        }

    });
   
    return userData; 
}

function insertUserIntoSQL(pool, username, github_url, linkedin_url, website_url, status){

    // Add logic to cut status that are too long(set a char limit of 200);

    pool.query(
        `CALL MigrateUserData('${username}', '${github_url}', '${linkedin_url}', '${website_url}', 'New Status');`, 
        (err, res) => {

            if(err){
                throw new Error(err);
            } else {
                console.log(`${username} was successfully exported to mundus_data`);
            }

        }
    );
    
}

/* Main */ 
async function main(){

    const sqliteDB = new Database(sqliteDatabasePath, { verbose: () => {
            console.log(`Connected to: ${sqliteDatabasePath}`);
    }});
    
    sqliteDB.pragma('journal_mode = WAL');
    
    let userData = await getUserDataFromSQLite(sqliteDB);
  
    // Close Database after getting data 
    sqliteDB.close();

    // connect to mySQL and create a pool 
    const pool = mysql.createPool(poolConfig);

    //iterate through userData and insert using the stored Proc

    userData.forEach(userItem => {
        insertUserIntoSQL(
            pool, 
            userItem.UserName, 
            userItem.Url1, 
            userItem.Url2, 
            userItem.Url3, 
            userItem.Status
        );
    });

    console.log("OK");
}

main();
