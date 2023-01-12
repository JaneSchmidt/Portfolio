const img = document.querySelectorAll('img');

img.forEach(image => {
    image.addEventListener('mouseover', toggleBlur);
    console.log("hi");
});

function toggleBlur() {
  console.log("hello");
}