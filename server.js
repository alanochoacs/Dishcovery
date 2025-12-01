// Backend server logic using Express and MySQL for Dishcovery
require("dotenv").config();

const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

const { pool } = require("./src/db");

// Serve static files
app.use(express.static(__dirname+ "/frontend"));

app.use((req, res, next) => {
  const start = process.hrtime.bigint();

  // Log when the response finishes so we can include status and duration
  res.on("finish", () => {
    const durationMs = Number(process.hrtime.bigint() - start) / 1_000_000; // ns -> ms
    const info = {
      method: req.method,
      url: req.originalUrl || req.url,
      status: res.statusCode,
      durationMs: Number(durationMs.toFixed(2)),
    };
    console.log(
      `[REQ] ${info.method} ${info.url} -> ${info.status} (${info.durationMs} ms)`
    );
  });

  next();
});

/**
 * Endpoint: Get all countries
 * Returns a list of ID and Names to populate dropdowns or lists
 */
app.get("/api/countries", async (req, res) => {
  let connection;
  try {
    connection = await pool.getConnection();
    const [rows] = await connection.execute(
      `SELECT id, country_name FROM country ORDER BY country_name ASC`
    );
    res.json(rows);
  } catch (error) {
    console.error("Database error", error);
    res.status(500).json({ error: "Failed to fetch countries" });
  } finally {
    if (connection) connection.release();
  }
});

// Search API querying the database
app.get("/api/search", async (req, res) => {
  const q = (req.query.q || "").trim(); // Get and trim query parameter from frontend
  const countryId = req.query.countryId; // Get optional countryId

  if (!q) return res.json([]); // Return empty array if no query

  let connection;
  try {
    connection = await pool.getConnection();

    let sql = `
  SELECT dish.id, dish.name, dish.description, dish.image_url, country.country_name
  FROM dish
  JOIN country ON country.id = dish.country_id
  WHERE (dish.name LIKE ? OR dish.description LIKE ?)
`;


    const params = [`%${q}%`, `%${q}%`];

    if (countryId) {
      sql += ` AND dish.country_id = ?`;
      params.push(countryId);
    }

    sql += ` LIMIT 50`;

    const [rows] = await connection.execute(sql, params);

    res.json(rows); // Send results as JSON to frontend
  } catch (error) {
    console.error("Database error", error); // Log database errors
    res.status(500).json({ error: "Database error" }); // Send error response to frontend
  } finally {
    if (connection) connection.release();
  }
});
/**
 * Endpoint: Get dishes to display on homepage (with images)
 */
app.get("/api/dishes", async (req, res) => {
  let connection;
  try {
    connection = await pool.getConnection();
    const [rows] = await connection.execute(`
      SELECT dish.name, dish.description, dish.image_url, country.country_name
      FROM dish
      JOIN country ON country.id = dish.country_id
      WHERE dish.image_url IS NOT NULL
      AND dish.image_url <> ''
      ORDER BY RAND()
      LIMIT 6
    `);
    res.json(rows);
  } catch (error) {
    console.error("Database error", error);
    res.status(500).json({ error: "Failed to fetch dishes" });
  } finally {
    if (connection) connection.release();
  }
});


// Print server start message to console
app.listen(PORT, () => {
  console.log(`Server listening on http://localhost:${PORT}`);
});
