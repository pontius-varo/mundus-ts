"use strict";
//import fs from 'fs';
import TelegramBot from "node-telegram-bot-api";

const port: number = 4444;

let myToken: string = "";


function foo(value: string): string{
    return value;
}

foo('Foobar');

const myFunc: Function = () => {
    console.log("This is my function!");
};

myFunc();

function getMyCords(pt: { x: number, y: number, area?: string}){
    return `My X is: ${pt.x}, My Y is: ${pt.y}, and my area is ${pt.area}`
}

// Both are valid
getMyCords({x: 123, y: 324324});
getMyCords({x: 12, y: 233, area: "foobar"});

// Type alias

type Person = {
    name: string;
    address: string;
    number: number;
}

// interface (can be extended)
interface Bob extends Person {
    bobness: string;
}


// will only accept person 'type' objects
function showPerson(person: Person){
    return console.log(person);
}
