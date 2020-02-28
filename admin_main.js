/**
 * TODO: ONLOAD loop over the OU Guests and fill in the table
 * TODO: ONCLICK delete the user from AD and remove it from the table
 * TODO: ONCLICK mail the contact person that the user is removed from the list.
 */

let json_data;
getJsonData();

function getJsonData() {
    let xmlhttp = new XMLHttpRequest();
    let location = "admin_guest_list.json";
    xmlhttp.onreadystatechange = onRSC;
    xmlhttp.open("GET", location, true);
    xmlhttp.setRequestHeader("Access-Control-Allow-Origin", "*");
    xmlhttp.send();
}

function onRSC(event) {
    if (event.target.readyState == 4 && event.target.status == 0) {
        json_data = JSON.parse(event.target.responseText);
    }
}


// object.addEventListener('load', fill_in_table_with_guests);
// addEventListener('onclick', remove_user_from_AD_and_table);
// addEventListener('onclick', mail_contact_person);


// function fill_in_table_with_guests() {

// }

// function remove_user_from_AD_and_table() {
//     let spawn = require("child_process").spawn;
//     spawn("PowerShell.exe", ["remove_selected_guest.ps1"]);
// }

// function mail_contact_person() {

// }