function init(){
  const img = document.querySelectorAll('img');

  img.forEach(image => {
      image.addEventListener("mouseenter", ()=> {
        switch(image.id){
          case "addWorkout" :
            image.src = "addWorkoutBlurred.jpg";
            break;
          case "stats" :
            image.src = "statisticsBlurred.png";
            console.log("1");
            break;
          case "table" :
            image.src = "tableBlurred.png";
            console.log("2");
            break;
          case "tracker" :
            image.src = "trackerBlurred.png";
            console.log("3");
            break;
        }

      });
  });

  img.forEach(image => {
    image.addEventListener("mouseleave", ()=>{
      switch(image.id){
        case "addWorkout" :
          image.src = "addWorkout.png";
          break;
        case "stats" :
          image.src = "statistics.png";
          break;
        case "table" :
          image.src = "workoutsTable.png";
          break;
        case "tracker" :
          image.src = "tracker.png";
          break;
      }
    });
});
}


init();