const fs = require("fs");
const path = require("path");
const { pool } = require("./db"); // Imports your CommonJS pool

const CSV_PATH = path.join(__dirname, "../database/foodculture_dishes_rev2.csv");
const dishImages = {
  "Biryani": "https://upload.wikimedia.org/wikipedia/commons/1/1b/Hyderabadi_Chicken_Biryani.jpg",
  "Tacos": "https://upload.wikimedia.org/wikipedia/commons/5/51/Plated_tacos.jpg",
  "Sushi": "https://upload.wikimedia.org/wikipedia/commons/6/60/Sushi_platter.jpg",
  "Pizza": "https://upload.wikimedia.org/wikipedia/commons/d/d3/Supreme_pizza.jpg",
  "Pad Thai": "https://upload.wikimedia.org/wikipedia/commons/4/4b/Pad_Thai_kung.jpg",
  "Poutine": "https://upload.wikimedia.org/wikipedia/commons/0/04/Poutine.jpg",
  "Paella": "https://upload.wikimedia.org/wikipedia/commons/3/39/Paella.jpg",
  "Kimchi": "https://upload.wikimedia.org/wikipedia/commons/9/9b/Kimchi.jpg",
  "Shawarma": "https://upload.wikimedia.org/wikipedia/commons/f/f9/Shawarma_plate.jpg",
  "Falafel": "https://upload.wikimedia.org/wikipedia/commons/7/7b/Falafel.jpg"
};
async function seed() {
  let connection;
  try {
    console.log("Starting seed process...");

    // 1. Read and Parse CSV
    const rawData = fs.readFileSync(CSV_PATH, "utf8");
    const lines = rawData.split(/\r?\n/).filter((line) => line.trim() !== "");

    if (lines.length < 2) {
      throw new Error("CSV file appears to be empty or missing headers");
    }

    // Extract Headers to identify ingredients (Index 5 onwards are ingredients)
    const headers = lines[0].split(";").map((h) => h.trim());
    const ingredientHeaders = headers.slice(5);

    console.log(`Found ${lines.length - 1} dishes to process.`);

    connection = await pool.getConnection();
    await connection.beginTransaction();

    // 2. Loop through data lines
    for (let i = 1; i < lines.length; i++) {
      const line = lines[i];
      const cols = line.split(";").map((c) => c.trim());

      // Skip malformed lines
      if (cols.length < 5) continue;

      // Extract Dish Data
      const countryName = cols[0];
      const dishName = cols[2];
      const description = cols[3];
      const isNational = cols[4] === "1" || cols[4].toLowerCase() === "true" ? 1 : 0;

      // A. Find Country ID
      const [countryRows] = await connection.execute(
        "SELECT id FROM country WHERE country_name = ? LIMIT 1",
        [countryName]
      );

      if (countryRows.length === 0) {
        console.warn(`Country not found: ${countryName} (Skipping dish: ${dishName})`);
        continue;
      }
      const countryId = countryRows[0].id;

      // B. Insert Dish WITH IMAGE
      const img = dishImages[dishName] || null;

      const [dishResult] = await connection.execute(
        `INSERT INTO dish (country_id, name, description, is_national_dish, image_url)
        VALUES (?, ?, ?, ?, ?)`,
        [countryId, dishName, description, isNational, img]
      );

      const dishId = dishResult.insertId;


      // C. Process Ingredients (Columns 5+)
      for (let j = 0; j < ingredientHeaders.length; j++) {
        const colIndex = j + 5;
        const hasIngredient = cols[colIndex] === "1";

        if (hasIngredient) {
          // Clean ingredient name (e.g., "sheep_lamb_mutton" -> "sheep lamb mutton")
          const rawIngredientName = ingredientHeaders[j];
          const ingredientName = rawIngredientName.replace(/_/g, " ");

          // D. Ensure Ingredient Exists (Upsert-ish logic)
          // First, try to select it
          let [ingRows] = await connection.execute(
            "SELECT id FROM ingredient WHERE name = ? LIMIT 1",
            [ingredientName]
          );

          let ingredientId;

          if (ingRows.length > 0) {
            ingredientId = ingRows[0].id;
          } else {
            // Create if doesn't exist
            const [ingInsert] = await connection.execute(
              "INSERT INTO ingredient (name) VALUES (?)",
              [ingredientName]
            );
            ingredientId = ingInsert.insertId;
          }

          // E. Link Dish to Ingredient
          await connection.execute(
            "INSERT IGNORE INTO dish_ingredient (dish_id, ingredient_id) VALUES (?, ?)",
            [dishId, ingredientId]
          );
        }
      }
      
      // Log progress every 10 items
      if (i % 10 === 0) process.stdout.write(".");
    }
    

    await connection.commit();
    console.log("\nDatabase seeded successfully!");
  } catch (err) {
    if (connection) await connection.rollback();
    console.error("\nSeeding failed:", err);
  } finally {
    if (connection) connection.release();
    process.exit();
  }
}


seed();