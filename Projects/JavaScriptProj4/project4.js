function init(){
    document.getElementById("image").src = "https://via.placeholder.com/300x200/fe8a96/000000?text=type for cute animal pic";
    document.getElementById("numOfWords").addEventListener("change" , function() {
        let words = document.getElementById("numOfWords").value;
        document.getElementById("header").innerHTML = "Every " + words + " words written will generate a new cute animal picture";
    });

    let wordCount = 0;
    document.getElementById("wordInput").addEventListener("keydown", function(e){
        words = document.getElementById("wordInput").value;
        let wordArr = words.split(' ');
        if(e.key != ' ' && wordCount != wordArr.length){
            wordCount = wordArr.length;
            enoughWords(wordCount);
        }
    });
}

init(); 


function enoughWords(wordCount){
    document.getElementById("currCount").innerHTML = "Current word count:" + wordCount;
    let amount = document.getElementById("numOfWords").value;
    let type = document.getElementById("catOrDog").value;
    if(wordCount % amount == 0 && wordCount != 0){
        switch(type){
        case 'cat':
            catClick();
            break;
        case 'dog':
            dogClick();
            break;
        case 'fox':
            foxClick();
            break;
        case 'surpise':
            surpriseClick();
        default:
            catClick();
      }
      
        getCatFact();
    }
}

async function catClick(){
    const URL = "https://api.thecatapi.com/v1/images/search";
    const response = await fetch(URL);
    if (response["ok"] == false){
         console.log("Error: something went wrong with the fetch");
    }
     else{
        const dataJSON = await response.json();
        const catPhoto = dataJSON[0].url;
        document.getElementById("image").src = catPhoto;
     }

}

async function dogClick(){
    const URL = "https://dog.ceo/api/breeds/image/random";
    const response = await fetch(URL);
    if (response["ok"] == false){
         console.log("Error: something went wrong with the fetch");
    }
     else{
        const dataJSON = await response.json();
        document.getElementById("image").src = dataJSON["message"];
     }
}

async function foxClick(){
    const URL = "https://randomfox.ca/floof/";
    const response = await fetch(URL);
    if (response["ok"] == false){
         console.log("Error: something went wrong with the fetch");
    }
     else{
        const dataJSON = await response.json();
        document.getElementById("image").src = dataJSON.image;
     }
}

async function surpriseClick(){
    const whichAnimal = Math.floor(Math.random() * (3 - 1 + 1) + 1);
    console.log(whichAnimal);
    switch(whichAnimal) {
        case 1:
            catClick();
            break;
        case 2:
            dogClick();
            break;
        case 3:
            foxClick();
            break;
        default:
            catClick();
      }
} 

async function getCatFact(){
    const URL = "https://catfact.ninja/fact";
    const response = await fetch(URL);
    if (response["ok"] == false){
        console.log("Error: something went wrong with the fetch");
    }
    else{
        const dataJSON = await response.json();
        const catFact = dataJSON.fact;
        document.getElementById("placeForFact").innerHTML = catFact;
    }
}
