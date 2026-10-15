// lightbox.js - click a picture on the home page to see the whole thing.
//
// WHY THIS EXISTS
//   The home page trims every picture into the same square box so the cards
//   line up. This little script lets a visitor click a picture to see all of
//   it, bigger, on top of a dimmed page. Click again (anywhere) or press
//   Escape to close it.
//
// HOW IT WORKS
//   There's one extra box (the "lightbox") hidden at the bottom of the page.
//   Clicking a card's picture copies that picture into the box and shows it.
//   It's the same image file from assets/img/, just not trimmed.
//   The look of the box lives in assets/css/style.css, under "Lightbox".
//
// You don't need to edit this file to add art: it works for every card
// by itself.

// Make the hidden box: a dark layer that holds one big picture.
const lightbox = document.createElement("div");
lightbox.className = "lightbox";
lightbox.hidden = true;
const bigPicture = document.createElement("img");
lightbox.appendChild(bigPicture);
document.body.appendChild(lightbox);

// The picture that was clicked, so we can go back to it when closing.
let lastPicture = null;

function openLightbox(picture) {
  bigPicture.src = picture.src;
  bigPicture.alt = picture.alt;
  lightbox.hidden = false;
  lastPicture = picture;
}

function closeLightbox() {
  lightbox.hidden = true;
  // Put the keyboard back on the picture the visitor opened.
  if (lastPicture) lastPicture.focus();
}

// Set up every card's picture.
for (const picture of document.querySelectorAll(".card img")) {
  // tabindex="0" lets people who use the keyboard (Tab key) reach the picture.
  picture.tabIndex = 0;
  picture.addEventListener("click", () => openLightbox(picture));
  // Enter or Space opens it too, like a button.
  picture.addEventListener("keydown", (event) => {
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault();
      openLightbox(picture);
    }
  });
}

// Clicking anywhere on the open lightbox (the picture or the dark area) closes it.
lightbox.addEventListener("click", closeLightbox);

// Pressing Escape closes it.
document.addEventListener("keydown", (event) => {
  if (event.key === "Escape" && !lightbox.hidden) closeLightbox();
});
