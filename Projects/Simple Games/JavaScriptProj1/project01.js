let answer = Math.random() * (101 - 1) + 1; 
answer = Math.floor(answer);
console.log(answer);

let sum = 0;
const lines = document.getElementsByClassName("words");

//function attached to guess button 
//check if guess is a number between 1 and 100
//check if guess is correct 
//change words to show whether it is too low, too high, or correct 
//changes number of guesses to correct amount 
//if correct disable guess button and input field until reset
function guessClick(){
    const guess = document.getElementById("guess");
    const guessNew = Number(guess.value);

    if(!Number.isInteger(guessNew)){
        lines[0].innerHTML = "Please enter an integer";
        lines[1].innerHTML = "Please guess again";
        document.getElementById("image").src = "makeAGuess.gif"
        return;
    }    
    if(guess.value < 0 || guessNew > 100){
        lines[0].innerHTML = "Integer is outside the guess range";
        lines[1].innerHTML = "Please guess again";
        document.getElementById("image").src = "makeAGuess.gif"
        return;
    }

    lines[1].innerHTML = "You guessed: " + guessNew;
    sum++;
    lines[2].innerHTML = "Number of guesses: " + sum;

    if(guessNew == answer){
        if(sum == 1){
            lines[0].innerHTML = "This number is Correct! This took you 1 try.";
        }
        else{
        lines[0].innerHTML = "This number is Correct! This took you " + sum + " tries.";
        }  
        document.getElementById("image").src = "winner.gif"
        document.getElementById("button1").disabled = true;
        document.getElementById("guess").disabled = true;
    } else if(guessNew > answer){
        lines[0].innerHTML = "This number is too high.";
        document.getElementById("image").src = "lower.gif"
    } else if(guessNew < answer){
        lines[0].innerHTML = "This number is too low.";
        document.getElementById("image").src = "higher.gif"

    }

    return;
}

//function attached to reset button 

//reset input field words
//enable buttons and input
//reset all the writing on the screen 
//change answer
function resetGame(){
    sum = 0;
    answer = Math.random() * (101 - 1) + 1; 
    answer = Math.floor(answer);
    document.getElementById("button1").disabled = false;
    document.getElementById("guess").disabled = false;
    document.getElementById("guess").value = "Make a guess";
    lines[0].innerHTML = "Good luck and have fun!";
    lines[1].innerHTML = "Awaiting guess...";
    lines[2].innerHTML = "Number of guesses: 0";
    document.getElementById("image").src = "makeAGuess.gif"
    return;
}