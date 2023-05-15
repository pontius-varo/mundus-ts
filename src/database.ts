"use strict";
import mysql from 'mysql2';
import * as dotenv from 'dotenv';
dotenv.config()

export function extractEnvironmentVariable(key: keyof NodeJS.ProcessEnv): string {
    
    let value = process.env[key];

    if(value === undefined){
        throw `${key} is not defined! Terminating...`;
    }

    return value;
};

const poolConfig = {
    host: extractEnvironmentVariable("SQL_HOST"),
    user: extractEnvironmentVariable("SQL_USER"),
    database: extractEnvironmentVariable("SQL_DATABASE"),
    password: extractEnvironmentVariable("SQL_USER_PASSWORD"),
    connectionLimit: 250,
}

const pool = mysql.createPool(poolConfig);

export async function executeSQL(query: string, params: Array<string>){
    
    try
    {
        let data = await pool.query<mysql.RowDataPacket[]>(query, params, (err) => {
            if(err){
                throw new Error('Error');
            } 
        });

        return data;

    } catch(e) { 
        console.error(e); 
    } 
}

