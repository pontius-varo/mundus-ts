"use strict";
//import fs from 'fs';
import TelegramBot, { Message } from "node-telegram-bot-api";
import mysql from 'mysql2';
import * as dotenv from 'dotenv';
dotenv.config()

const port: number = 4444;

// API Key
let botToken: string;

function extractEnvironmentVariable(key: keyof NodeJS.ProcessEnv): string {
    
    let value = process.env[key];

    if(value === undefined){
        throw `${key} is not defined! Terminating...`;
    }

    return value;
};

function getUserInfo(msg: Message, username: string): string {

    let userInfo: string = '';

    // proc name: GetUserInfo
    // should return a string only showing data the user has (ie only has website + github, etc)

    if(username == 'None'){
        // use the username defined in msg 
        // get user info from SQL by invoking a proc;
    } else {
        // use the username passed in the invocation
        // get user info from SQL by invoking a proc;
    }


    return userInfo;
};


// NIRN_BOT_API_KEY
function main(): void {

    const poolConfig = {
        host: extractEnvironmentVariable("SQL_HOST"),
        user: extractEnvironmentVariable("SQL_USER"),
        database: extractEnvironmentVariable("SQL_DATABASE"),
        password: extractEnvironmentVariable("SQL_USER_PASSWORD"),
        connectionLimit: 250,
    }


    let isTesting: string = extractEnvironmentVariable("TESTING");

    if(isTesting == "true"){
        botToken = extractEnvironmentVariable("NIRN_BOT_API_KEY");
    } else {
        botToken = extractEnvironmentVariable("PRODUCTION_BOT_API_KEY");
    }

    // Create the bot 
    const bot: TelegramBot = new TelegramBot(botToken, { polling: true });

    // getuser command 
    bot.onText(/\/getuser (.+)/, (msg, match) => {

        let response: string;
        
        // if match is not undefined, pass it through. Else, pass an empty string
        response = getUserInfo(msg, match ? match[1] : 'None') ;
        
        // Return user data
        bot.sendMessage(msg.chat.id, response);
    });

};