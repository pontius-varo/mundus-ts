import Database from 'better-sqlite3';

// Get Env here 

let dataPath = './neodatabase';

const db = new Database(dataPath, { verbose: () => {
    // print env here 
        console.log(`Connected to: ${dataPath}`);
}});

db.pragma('journal_mode = WAL');

const statement = db.prepare('SELECT * FROM Userlib;');
// const result = statement.all();

let count = 1;

let data = [];

for(let user of statement.iterate()){
    user.realId = count; 

    data.push(user);

    count++; 
}

// Close Database after getting data 
db.close();