// Backend server logic using Express and MySQL for Dishcovery
require("dotenv").config();

const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

const { pool } = require("./src/db");

// Serve static files
app.use(express.static(__dirname));

// Search API querying the database
app.get("/api/search", async (req, res) => {
  const q = (req.query.q || "").trim(); // Get and trim query parameter from frontend
  if (!q) return res.json([]); // Return empty array if no query

  let connection;
  try {
    connection = await pool.getConnection(); // Setup connection to frontend
    // Perform search query
    const [rows] = await connection.execute(
      `SELECT dish.id, dish.name, dish.description, country.country_name
             FROM dish
             JOIN country ON country.id = dish.country_id
             WHERE dish.name LIKE ? OR dish.description LIKE ?
             LIMIT 50`,
      [`%${q}%`, `%${q}%`]
    );
    res.json(rows); // Send results as JSON to frontend
  } catch (error) {
    console.error("Database error", error); // Log database errors
    res.status(500).json({ error: "Database error" }); // Send error response to frontend
  } finally {
    if (connection) connection.release();
  }
});

// Print server start message to console
app.listen(PORT, () => {
  console.log(`Server listening on http://localhost:${PORT}`);
});
