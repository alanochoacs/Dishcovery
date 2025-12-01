// Frontend search logic for Dishcovery
(() => {
  // Get references to html elements
  const queryElement = document.getElementById("query");
  const countrySelect = document.getElementById("countrySelect");
  const resultsElement = document.getElementById("results");

  function loadCountries() {
    fetch("/api/countries")
      .then((r) => r.json())
      .then((countries) => {
        countries.forEach((country) => {
          const option = document.createElement("option");
          option.value = country.id;
          option.textContent = country.country_name;
          countrySelect.appendChild(option);
        });
      })
      .catch((err) => console.error("Failed to load countries", err));
  }

  // Render search results to the page
  function render(results) {
    resultsElement.innerHTML = "";

    // Handle no results found
    if (!results || results.length === 0) {
      resultsElement.innerHTML = "<li>No results</li>";
      return;
    }

    // Dynamically create search results list
    for (const row of results) {
      const li = document.createElement("li"); // Create a list item for each result

      const title = row.name || row.Dish || row.Name || "Dish";
      const description = row.description || row.Description || "";
      const country =
        row.country_name || row.Country || row.Country_of_Origin || "";

      // Set the html of the list item (Curently shows dish name, description, and country)
      li.innerHTML =
        `<div><b>${escapeHtml(title)}</b></div>` +
        (description ? `<div>${escapeHtml(description)}</div>` : "") +
        (country ? `<div class="meta">${escapeHtml(country)}</div>` : "");

      resultsElement.appendChild(li); // Add item to list of results
    }
  }

  // Handles characters like é, ü, ñ, or even symbols like <, >, & that could break the html
  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;");
  }

  let timer = null;

  // Perform the search by querying the backend API
  function doSearch() {
    const query = queryElement.value.trim(); // Setup the query string
    const countryId = countrySelect.value;

    // If the query is empty, clear results and return
    if (query.length === 0) {
      resultsEl.innerHTML = "";
      return;
    }

    const params = new URLSearchParams({ q: query });
    if (countryId) {
      params.append("countryId", countryId);
    }

    // Fetch search results from the backend API
    fetch(`/api/search?${params.toString()}`)
      .then((r) => r.json())
      .then((data) => render(data))
      .catch((error) => {
        resultsElement.innerHTML = "<li>Error searching</li>";
        console.error(error);
      });
  }

  loadCountries();

  // Event listener for the search bar that triggers when the search input changes
  queryElement.addEventListener("input", () => {
    // Debounce logic for the search to avoid too many requests
    clearTimeout(timer);
    timer = setTimeout(doSearch, 300);
  });

  countrySelect.addEventListener("change", () => {
    doSearch();
  });
})();
