console.log("Dishes.js loaded!");

async function loadDishes() {
  try {
    const response = await fetch("/api/dishes");
    const dishes = await response.json();

    const grid = document.getElementById("resultsGrid");
    grid.innerHTML = ""; // Clear placeholders

    dishes.forEach(dish => {
      const card = document.createElement("div");
      card.className = "dish-card";

      card.innerHTML = `
      <div class="dish-image">
        <img src="${dish.image_url}" alt="${dish.name}" />
      </div>
      <div class="dish-info">
        <div class="dish-name">${dish.name}</div>
        <div class="dish-origin">${dish.country_name}</div>
        <div class="dish-description">${dish.description || "No details available"}</div>
      </div>
    `;


      grid.appendChild(card);
    });
  } catch (err) {
    console.error("Failed to load dishes:", err);
  }
}

// Run on page load WITHOUT affecting your other JS
window.addEventListener("DOMContentLoaded", loadDishes);
