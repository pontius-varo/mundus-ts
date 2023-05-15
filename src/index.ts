"use strict";
//import fs from 'fs';
import TelegramBot, { Message } from "node-telegram-bot-api";
import { executeSQL, extractEnvironmentVariable } from "./database.js";
import * as dotenv from 'dotenv';
dotenv.config()

const port: number = 4777;

// API Key | Global 
var botToken: string;

function getUserInfo(msg: Message, username: string): string {

    // You should tell the user that they can't add another user, only themselves....

    let userInfoQuery: string = `CALL GetUserInfo(?)`;
    let userInfoData: string;
    let realUserName: string | undefined;
    let rawData; 

    function santizeUserInfoData(data, username: string): string { 

        let santizedData:string = `${username}\n`; 

        if(data != null && data.rows.length != 0){
            data.rows.forEach(row => {
                
                santizedData = santizedData + `${row.type}: ${row.url}\n`;

            });
        } else {
            santizedData = santizedData + 'Has No Info Data!';
        }

        return santizedData;
    }

    realUserName = username == 'None' ? msg.from?.username : username;

    rawData = executeSQL(userInfoQuery, [ realUserName ? realUserName : '@aurelianus_varo' ]);

    userInfoData = santizeUserInfoData(rawData.rows, username);

    return userInfoData;
};


function createNewUser(msg: Message, username: string){

    let query: string = `CALL CreateNewUser(?)`;
    let response: string = '';

    if(username) { 
        executeSQL(query, [username]);
        response = `${username} you have been added to the database.`
    } else {
        response = `Invalid. Create a username before invoking this function`;
    }

    return response;
}
// This function is very similar to the previous...why repeat yourself?
function getUserStatus(msg: Message, username: string){
    let query: string = 'CALL GetUserStatus(?)';
    let response: string = '';

    function sanitize(data){

        if(data.rows.length != 0){
            return data.rows[0].status;
        } else {
            return 'No status has been set';
        }

    }

    if(username){
        let rawData = executeSQL(query, [username]);
        // similar issue as sanitizeUserInfo. Maybe create a shared function?
        response = sanitize(rawData);
    } else { 
        // might want to change wording here..
        response = 'Invalid. Either your username doesn\'t exist or something else is remiss.' 
    }

    return 
}

function setUserStatus(msg: Message, username: string, status: string){
    let query: string = 'CALL SetUserStatus(?, ?)';
    let response: string = '';

    if(username && status){
        executeSQL(query, [username, status]);
        response = `Your status has been set, ${username}!`;
    } else {
        response = 'Either your username or new status is invalid. Try again!';
    }

}


function main(): void {

    // Might want to handle this elsewhere...
    let isTesting: string = extractEnvironmentVariable("TESTING");

    if(isTesting.toUpperCase() == "TRUE"){
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

    // Create New User command 

    bot.onText(/\/adduser/, (msg, match) => {

        let response: string; 

        response = createNewUser(msg, match[1]);

        bot.sendMessage(msg.chat.id, response);

    });

};