let searchType = "name"; // Default search type to "name"

// Function to change search type and update UI
function changeSearchType(type) {
  searchType = type;
  document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
  document.getElementById(type + 'Filter').classList.add('active');
  document.getElementById("searchInput").placeholder = `Search by ${type}...`;

  console.log("Search type changed to:", searchType);
}

async function performSearch() {
  const query = document.getElementById("searchInput").value.trim();
  if (!query) return;

  const grid = document.getElementById("resultsGrid");
  grid.innerHTML = `<p style="color:white;font-size:22px;">Searching...</p>`;

  try {
    const response = await fetch(`/api/search?q=${encodeURIComponent(query)}&type=${encodeURIComponent(searchType)}`);
    const dishes = await response.json();

    grid.innerHTML = ""; // Clear loading text

    if (dishes.length === 0) {
      grid.innerHTML = `<p style="color:white;font-size:20px;">No dishes found ❌</p>`;
      return;
    }

    dishes.forEach(dish => {
      const card = document.createElement("div");
      card.className = "dish-card";

      const is_national_dish = dish.is_national_dish ? '<span title="National Dish">⭐</span>' : '';

      card.innerHTML = `
        <div class="dish-image">
          ${dish.image_url 
            ? `<img src="${dish.image_url}" style="width:100%;height:200px;object-fit:cover;">` 
            : "🍽️"}
        </div>
        <div class="dish-info">
          <div class="dish-name">${dish.name}</div>
          <div class="dish-origin">${is_national_dish} ${dish.country_name}</div>
          <div class="dish-description">${dish.description || "No details available"}</div>
        </div>
      `;
      grid.appendChild(card);
    });

  } catch (err) {
    console.error("Search failed:", err);
  }
}

// Enter key triggers search
document.getElementById('searchInput').addEventListener('keypress', function(event) {
  if (event.key === 'Enter') performSearch();
});

async function getRandomDish() {
  const grid = document.getElementById("resultsGrid");
  grid.innerHTML = `<p style="color:white;font-size:22px;">Finding a random dish...</p>`;

  try {
    const response = await fetch('/api/random-dish');
    const dishes = await response.json();

    grid.innerHTML = ""; 

    if (dishes.length === 0) {
      grid.innerHTML = `<p style="color:white;font-size:20px;">No dishes found ❌</p>`;
      return;
    }

    dishes.forEach(dish => {
      const card = document.createElement("div");
      card.className = "dish-card";

      card.innerHTML = `
        <div class="dish-image">
          ${dish.image 
            ? `<img src="${dish.image}" style="width:100%;height:200px;object-fit:cover;">` 
            : "🍽️"}
        </div>
        <div class="dish-info">
          <div class="dish-name">${dish.name}</div>
          <div class="dish-origin">${dish.country}</div>
          <div class="dish-description">${dish.description || "No details available"}</div>
          ${dish.categories.length ? `<div style="margin-top:10px;color:rgba(255,255,255,0.8);">Categories: ${dish.categories.join(', ')}</div>` : ''}
        </div>
      `;
      grid.appendChild(card);
    });

  } catch (err) {
    console.error("Random dish failed:", err);
    grid.innerHTML = `<p style="color:white;font-size:20px;">Error loading dish ❌</p>`;
  }
}