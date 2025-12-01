// src/fetchWikiImages.js
require("dotenv").config();
const fs = require("fs");
const path = require("path");
const { pool } = require("./db"); // same as seed.js

// Where we will save the generated mapping
const OUTPUT_PATH = path.join(__dirname, "dishImages.generated.json");

// If you're on Node 18+, fetch is built-in. If not, install node-fetch and uncomment:
// const fetch = (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args));

async function getDishNames() {
  const [rows] = await pool.execute(
    "SELECT DISTINCT name FROM dish WHERE name IS NOT NULL ORDER BY name"
  );
  return rows.map((r) => r.name);
}

async function fetchImageForDish(dishName) {
  // Basic Wikipedia REST API endpoint
  const url =
    "https://en.wikipedia.org/api/rest_v1/page/summary/" +
    encodeURIComponent(dishName);

  try {
    const res = await fetch(url, {
      headers: {
        "User-Agent": "Dishcovery/1.0 (mailto:your-email@example.com)",
        "Accept": "application/json",
      },
    });

    if (!res.ok) {
      console.warn(`  ✖ ${dishName}: HTTP ${res.status}`);
      return null;
    }

    const data = await res.json();

    // Prefer full image, fall back to thumbnail
    const img =
      (data.originalimage && data.originalimage.source) ||
      (data.thumbnail && data.thumbnail.source) ||
      null;

    if (!img) {
      console.warn(`  ✖ ${dishName}: no image in summary`);
    }

    return img;
  } catch (err) {
    console.warn(`  ✖ ${dishName}: error ${err.message}`);
    return null;
  }
}

async function main() {
  let connection;
  try {
    console.log("🔎 Fetching dish names from database...");
    const dishNames = await getDishNames();
    console.log(`Found ${dishNames.length} distinct dishes.`);

    const mapping = {};

    for (let i = 0; i < dishNames.length; i++) {
      const name = dishNames[i];
      console.log(`(${i + 1}/${dishNames.length}) ${name} ...`);

      const imgUrl = await fetchImageForDish(name);
      mapping[name] = imgUrl; // can be null if not found

      // tiny delay to be nice to Wikipedia
      await new Promise((resolve) => setTimeout(resolve, 150));
    }

    // Save to JSON file
    fs.writeFileSync(OUTPUT_PATH, JSON.stringify(mapping, null, 2), "utf8");
    console.log(`\n✅ Done! Saved image mapping to:\n  ${OUTPUT_PATH}`);
  } catch (err) {
    console.error("❌ Failed to generate image mapping:", err);
  } finally {
    if (pool) {
      await pool.end();
    }
  }
}

main();
