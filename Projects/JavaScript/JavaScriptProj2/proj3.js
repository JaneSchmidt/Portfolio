const allData = [];

function init(){
    document.getElementById("north-radio").onclick = function(){
        document.getElementById("highschool-input").disabled = true;
    }
    document.getElementById("south-radio").onclick = function(){
        document.getElementById("highschool-input").disabled = true;
    }
    document.getElementById("other-radio").onclick = function(){
        document.getElementById("highschool-input").disabled = false;
    }
    document.getElementById("na-radio").onclick = function(){
        document.getElementById("highschool-input").disabled = true;
    }

    loadJSON("proj3.json");
}
init();

function loadJSON(fileName){
    // use XMLHttpRequest to get JSON file contents
    const xobj = new XMLHttpRequest();
    xobj.overrideMimeType("application/json");
    xobj.open("GET", fileName);
    xobj.onreadystatechange = () => {
        if (xobj.readyState == 4 && xobj.status == 200){
            // get the text as a raw string
            const responseText = xobj.responseText;
            // parse raw string into JSON object. Stored globally
            dataJSON = JSON.parse(responseText);
            loadTable(dataJSON);
        }
    };
    xobj.send();
}

// called by loadJSON, creates table on page load 
// for each record process the JSON data and add it to the table 
function loadTable(data){
    const dataJ = {};
    data.forEach( (record) => {
        dataJ.firstName = record.firstName;
        dataJ.lastName = record.lastName;

        if(record.under18){
            dataJ.underEighteen = 'Yes';
        } else{
            dataJ.underEighteen = 'No';
        }

        dataJ.email = record.email;
        dataJ.grade = record.grade;
        dataJ.highSchool = record.highschool;

        let sessionOneStr = "";
        if(record.session1.length > 1){
            for(let i = 0; i < record.session1.length; i++){
                if(i == record.session1.length-1){
                    sessionOneStr = sessionOneStr + record.session1[i];
                }
                else{
                    sessionOneStr = sessionOneStr + record.session1[i] + ", ";
                }
            }
        }
        
        if(record.session1.length == 0){
            sessionOneStr = "";
        }
        else if(record.session1.length == 1){
            sessionOneStr = sessionOneStr + record.session1[0];
        }

        let sessionTwoStr = "";
        if(record.session2.length > 1){
            for(let i = 0; i < record.session2.length; i++){
                if(i == record.session2.length-1){
                    sessionTwoStr = sessionTwoStr + record.session2[i];
                }
                else{
                    sessionTwoStr = sessionTwoStr + record.session2[i] + ", ";
                }
            }
        }
        if(record.session2.length == 0){
            sessionTwoStr = "";
        }
        else if(record.session2.length == 1){
            sessionTwoStr = sessionTwoStr + record.session2[0];
        }

        dataJ.session1 = sessionOneStr;
        dataJ.session2 = sessionTwoStr;
        dataJ.timeStamp = record.timestamp;

        allData.push({"firstName": dataJ.firstName,
        "lastName": dataJ.lastName,
        "underEighteen": dataJ.underEighteen,
        "email": dataJ.email,
        "timeStamp": dataJ.timeStamp,
        "grade": dataJ.grade,
        "highSchool": dataJ.highSchool,
        "session1": dataJ.session1,
        "session2": dataJ.session2});

        addRow(dataJ);
    });
    document.getElementById("num").innerHTML = "Total: " + allData.length + " students";
}

// functionality for the register button 
const form = document.getElementById("summerCampRegistration");
form.addEventListener("submit", (event) => {
    event.preventDefault();
    new FormData(form);
});

// adding a record to the form 
form.addEventListener("formdata", (event) => {
    const data = event.formData;
    const dataJson = {};

    for (const [key,value] of data.entries()){
        dataJson[key] = value;
    }

    const entry = {};

    // error produced if the email already exists in database 
    let alertEmail = 0;
    allData.forEach((record) => {
        if(dataJson.email === record.email){
            alertEmail = 1;
        }
    });

    if(alertEmail == 1){
        alert("This email is already registered.")
    }
    else{
        entry.firstName = dataJson.firstName;
        entry.lastName = dataJson.lastName;

        if(dataJson.isUnderEighteen == 'on'){
            entry.underEighteen = 'Yes';
        }
        else{
            entry.underEighteen = 'No';
        }

        entry.email = dataJson.email;
        entry.grade = dataJson.schoolGrade;
        entry.highSchool = dataJson.highschool;

        let sessionOneAr = [];
        if(dataJson.session1slot1 !== 'None'){
            sessionOneAr.push(dataJson.session1slot1);
        }
        if(dataJson.session1slot2 !== 'None'){
            sessionOneAr.push(dataJson.session1slot2);
        }
        if(dataJson.session1slot3 !== 'None'){
            sessionOneAr.push(dataJson.session1slot3);
        }
        if(dataJson.session1slot4 !== 'None'){
            sessionOneAr.push(dataJson.session1slot4);
        }

        let sessionOneStr = "";
        if(sessionOneAr.length > 1){
            for(let i = 0; i < sessionOneAr.length; i++){
                if(i == sessionOneAr.length-1){
                    sessionOneStr = sessionOneStr + sessionOneAr[i];
                }
                else{
                    sessionOneStr = sessionOneStr + sessionOneAr[i] + ", ";
                }
            }
        }
        if(sessionOneAr.length == 0){
            sessionOneStr = "";
        }
        else if(sessionOneAr.length == 1){
            sessionOneStr = sessionOneStr + sessionOneAr[0];
        }

        let sessionTwoAr = [];
        if(dataJson.session2slot1 !== 'None'){
            sessionTwoAr.push(dataJson.session2slot1);
        }
        if(dataJson.session2slot2 !== 'None'){
            sessionTwoAr.push(dataJson.session2slot2);
        }
        if(dataJson.session2slot3 !== 'None'){
            sessionTwoAr.push(dataJson.session2slot3);
        }
        if(dataJson.session2slot4 !== 'None'){
            sessionTwoAr.push(dataJson.session2slot4);
        }

        let sessionTwoStr = "";
        if(sessionTwoAr.length > 1){
            for(let i = 0; i < sessionTwoAr.length; i++){
                if(i == sessionTwoAr.length-1){
                    sessionTwoStr = sessionTwoStr + sessionTwoAr[i];
                }
                else{
                    sessionTwoStr = sessionTwoStr + sessionTwoAr[i] + ", ";
                }
            }
        }
        if(sessionTwoAr.length == 0){
            sessionTwoStr = "";
        }
        else if(sessionTwoAr.length == 1){
            sessionTwoStr = sessionTwoStr + sessionTwoAr[0];
        }

        entry.session1 = sessionOneStr;
        entry.session2 = sessionTwoStr;

        const now = new Date();
        const year = now.getFullYear();
        const month = now.getMonth();
        const date = now.getDate();
        const hours = now.getHours();
        const min = now.getMinutes();
        entry.timeStamp = `${year}-${month}-${date}  ${hours}:${min}`;

        allData.push({"firstName": entry.firstName,
        "lastName": entry.lastName,
        "underEighteen": entry.underEighteen,
        "email": entry.email,
        "timeStamp": entry.timeStamp,
        "grade": entry.grade,
        "highSchool": entry.highSchool,
        "session1": entry.session1,
        "session2": entry.session2});
        document.getElementById("num").innerHTML = "Total: " + allData.length + " students";

        addRow(entry);
    }

    //reseting defaults
    document.getElementById("below-radio").checked = true;
    document.getElementById("north-radio").checked = true;

    document.getElementById("s1s1c4-radio").checked = true;
    document.getElementById("s1s2c4-radio").checked = true;
    document.getElementById("s1s3c4-radio").checked = true;
    document.getElementById("s1s4c4-radio").checked = true;

    document.getElementById("s2s1c4-radio").checked = true;
    document.getElementById("s2s2c4-radio").checked = true;
    document.getElementById("s2s3c4-radio").checked = true;
    document.getElementById("s2s4c4-radio").checked = true;

    document.getElementById("isUnderEighteen-checkbox").checked = false;
        
    document.getElementById('firstName-input').value = '';
    document.getElementById('lastName-input').value = '';
    document.getElementById('email-input').value = '';
    document.getElementById("highschool-input").disabled = true;
    document.getElementById('highschool-input').value = '';
});

// appends a row to the table with all necessary information 
function addRow(data){
    const table = document.getElementById("registrar-table");
    const newRow = document.createElement("tr");

    const newName = document.createElement("td");
    newName.innerHTML = data.lastName + ", " + data.firstName;

    const email = document.createElement("td");
    email.innerHTML = data.email;

    const newDateTime = document.createElement("td");
    newDateTime.innerHTML = data.timeStamp;

    const grade = document.createElement("td");
    grade.innerHTML = data.grade;

    const hSchool = document.createElement("td");
    hSchool.innerHTML = data.highSchool;

    const sesOne = document.createElement("td");
    sesOne.innerHTML = data.session1;

    const sesTwo = document.createElement("td");
    sesTwo.innerHTML = data.session2;

    const underE = document.createElement("td");
    underE.innerHTML = data.underEighteen;

    newRow.appendChild(newName);
    newRow.appendChild(underE);
    newRow.appendChild(email);
    newRow.appendChild(newDateTime);
    newRow.appendChild(grade);
    newRow.appendChild(hSchool);
    newRow.appendChild(sesOne);
    newRow.appendChild(sesTwo);
    table.appendChild(newRow);
}

// filters through all the data to find the records with the searched course
function searchClick(){
    let searchedCourse = document.getElementById("search-input").value;

    const table = document.getElementById("registrar-table");
    
    while (table.childNodes.length > 2){
        table.removeChild(table.lastChild);
    }

    let filteredData = allData.filter( (allData) => {
        let ses1 = allData.session1;
        let ses2 = allData.session2;
        return (ses1.includes(searchedCourse) || ses2.includes(searchedCourse));
    });

    document.getElementById("num").innerHTML = "Total: " + filteredData.length + " students";
    filteredData.forEach( (record) => {
        addRow(record);
    });
}

// functionality of the reset button 
// resets the table to show all data after a search 
function resetClick(){
    document.getElementById("num").innerHTML = "Total: " + allData.length + " students";
    document.getElementById("search-input").value = "";
    const table = document.getElementById("registrar-table");
    while (table.childNodes.length > 2){
        table.removeChild(table.lastChild);
    }

    allData.forEach((record) => {
        addRow(record);
    });
}

