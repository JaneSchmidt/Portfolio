const img = document.querySelectorAll('img');

img.forEach(image => {
    image.addEventListener('mouseover', blurPhoto(image.id));
});

function blurPhoto(id) {
  console.log(id);
}

function init(){
  console.log("hi");
  document.getElementById("addWorkout").mouseover = function(){
    console.log("1");
    //document.getElementById("addWorkout").src = "blurredWorkout.png";
  }
  document.getElementById("tracker").mouseover = function(){
    console.log("2");
  }
  document.getElementById("stats").mouseover = function(){
    console.log("3");
  }
  document.getElementById("table").mouseover = function(){
    console.log("4");
  }

}
init();