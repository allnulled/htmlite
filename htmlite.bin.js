#!/usr/bin/env node
const files = process.argv.splice(2);
const fs = require("fs");
const htmlite = require(__dirname + "/htmlite.parser.js");
let set_doctype = false;
for(let index = 0; index < files.length; index++) {
    const file = files[index];
    if(file.startsWith("--")) {
        if(file === "--doctype") {
            set_doctype = true;
        }
    }
    const htmlite_contents = fs.readFileSync(file).toString();
    let html_contents = htmlite.parse(htmlite_contents).html;
    if (set_doctype) {
        html_contents = "<!DOCTYPE html>\n" + html_contents;
    }
    fs.writeFileSync(file.replace(/\.htmlite$/g, ".html"), html_contents, "utf8");
};