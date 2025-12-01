require("dotenv").config();
const fs = require("fs");
const path = require("path");
const { pool } = require("./db"); // same pool from your seed.js

// Load the generated image mapping JSON
const dishImages = require("./dishImages.generated.json");

async function updateImages() {
  console.log("Updating dish image URLs in database... 🔄");

  const connection = await pool.getConnection();
  let updatedCount = 0;

  try {
    await connection.beginTransaction();

    for (const [dishName, imageUrl] of Object.entries(dishImages)) {
      if (!imageUrl) continue; // skip null entries

      const [result] = await connection.execute(
        "UPDATE dish SET image_url = ? WHERE name = ?",
        [imageUrl, dishName]
      );

      if (result.affectedRows > 0) {
        updatedCount++;
        console.log(`  ✅ Updated ${dishName}`);
      }
    }

    await connection.commit();
    console.log(`\n🎉 Done! Updated ${updatedCount} dishes with images.`);
  } catch (err) {
    await connection.rollback();
    console.error("❌ Error updating image URLs:", err);
  } finally {
    connection.release();
    process.exit();
  }
}

updateImages();
