let answer = Math.random() * (101 - 1) + 1; 
answer = Math.floor(answer);
console.log("Answer = " + answer);
let tries =  0;
let clicked = [];

init();

//initialization function to create buttons
function init(){ 
    
    for(let i = 1; i < 101; i++){
        let guessBtns = [];
        // creating buttons using creatElement then adding them to the div section using appendChild
        guessBtns[i] = document.createElement("button");
        guessBtns[i].id = i;
        document.getElementById("guessButtons").appendChild(guessBtns[i]);
        guessBtns[i].innerText = i;

        //adding the click listener to display correct message, change color, and disable specific guess button
        guessBtns[i].addEventListener("click", () =>{ 
            tries++;
            if(i == answer){
                alert("You got the correct number " + answer + " in " + tries + " tries!")
                document.getElementById("makeAGuess").innerHTML = "Correct! The number is " + answer;
                document.getElementById(i).style.backgroundColor = 'yellow';
                finishGame();
            }
            else if(i > answer){
                document.getElementById("makeAGuess").innerHTML = "Too high!";
                setTimeout(() => {
                    document.getElementById("makeAGuess").innerHTML = "Make a guess!";
                }, 500);
                document.getElementById(i).style.backgroundColor = 'green';
                guessBtns[i].disabled = true;
            }
            else if(i < answer){
                document.getElementById("makeAGuess").innerHTML = "Too low!";
                setTimeout(() => {
                    document.getElementById("makeAGuess").innerHTML = "Make a guess!";
                }, 500);
                document.getElementById(i).style.backgroundColor = 'red';
                guessBtns[i].disabled = true;
            }
        });

        // mouse enter and leave listeners to change color of buttons when hovering
        guessBtns[i].addEventListener("mouseenter", () => {   
            guessBtns[i].style.backgroundColor = "blue";
          }, false);
        guessBtns[i].addEventListener("mouseleave", () => {   
            guessBtns[i].style.backgroundColor = "pink";
          }, false);
    }
}

// disables all buttons at the end of the game
function finishGame(){
    for(let i = 1; i < 101; i ++){
        document.getElementById(i).disabled = true;
    }
}

//function for the resetbutton to reset to default functionality 
function resetClick(){
    for(let i = 1; i < 101; i ++){
        document.getElementById(i).style.backgroundColor = 'pink';
        document.getElementById(i).disabled = false;
        answer = Math.random() * (101 - 1) + 1; 
        answer = Math.floor(answer);
        tries = 0;
        document.getElementById("makeAGuess").innerHTML = "Make a guess!";
    }
}
