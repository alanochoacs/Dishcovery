// Backend server logic using Express and MySQL for Dishcovery
require("dotenv").config();

const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

const { pool } = require("./src/db");
const e = require("express");

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
  const type = (req.query.type || "name").trim();

  if (!q) return res.json([]); // Return empty array if no query

  let connection;
  try {
    connection = await pool.getConnection();

    let sql = "";
    let params = [];

    if (type === "name") {
      sql = `
        SELECT dish.name, dish.description, dish.image_url, country.country_name, dish.is_national_dish
        FROM dish
        JOIN country ON country.id = dish.country_id
        WHERE (dish.name LIKE ? OR dish.description LIKE ?)
        LIMIT 50
      `;
      params = [`%${q}%`, `%${q}%`];
    } else if (type === "country") {
      sql = `
        SELECT dish.name, dish.description, dish.image_url, country.country_name, dish.is_national_dish
        FROM dish
        JOIN country ON country.id = dish.country_id
        WHERE country.country_name LIKE ?
        LIMIT 50
      `;
      params = [`%${q}%`];
    } else if (type === "continent") {
      sql = `
        SELECT dish.name, dish.description, dish.image_url, country.country_name, dish.is_national_dish
        FROM dish
        JOIN country ON country.id = dish.country_id
        JOIN region ON region.id = country.region_id
        WHERE region.name LIKE ?
        LIMIT 50
      `;
      params = [`%${q}%`];
    } else if (type === "language") {
      sql = `
        SELECT dish.name, dish.description, dish.image_url, country.country_name, dish.is_national_dish
        FROM dish
        JOIN country ON country.id = dish.country_id
        JOIN language ON language.id = country.main_language_id
        WHERE language.name LIKE ?
        LIMIT 50
      `;
      params = [`%${q}%`];
   } else if (type === "category") {
      sql = `
        SELECT dish.*, country.country_name, category.category_name
        FROM dish
        JOIN dish_category ON dish_category.dish_id = dish.id
        JOIN category ON category.id = dish_category.category_id
        JOIN country ON country.id = dish.country_id
        WHERE category.category_name LIKE ?
        LIMIT 50
      `;
      params = [`%${q}%`];
    }


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
      SELECT 
        dish.id,
        dish.name,
        dish.description,
        dish.image_url,
        country.country_name,
        category.category_name
      FROM dish
      JOIN country ON country.id = dish.country_id
      LEFT JOIN dish_category ON dish_category.dish_id = dish.id
      LEFT JOIN category ON category.id = dish_category.category_id
      WHERE dish.image_url IS NOT NULL
        AND dish.image_url <> ''
      ORDER BY RAND()
      LIMIT 6
    `);

    // GROUP BY dish so categories come as array
    const grouped = rows.reduce((acc, row) => {
      if (!acc[row.id]) {
        acc[row.id] = {
          id: row.id,
          name: row.name,
          description: row.description,
          image_url: row.image_url,
          country: row.country_name,
          categories: [],
        };
      }
      if (row.category_name) acc[row.id].categories.push(row.category_name);
      return acc;
    }, {});

    res.json(Object.values(grouped)); // return array of dishes
  } catch (error) {
    console.error("Database error", error);
    res.status(500).json({ error: "Failed to fetch dishes" });
  } finally {
    if (connection) connection.release();
  }
});

//randome dish generator
app.get("/api/random-dish", async (req, res) => {
  let connection;
  try {
    const count = Number(req.query.count) || 1;

    connection = await pool.getConnection();

    const [rows] = await connection.query(`
      SELECT 
        dish.id,
        dish.name,
        dish.description,
        dish.image_url,
        country.country_name,
        category.category_name
      FROM dish
      JOIN country ON country.id = dish.country_id
      LEFT JOIN dish_category ON dish_category.dish_id = dish.id
      LEFT JOIN category ON category.id = dish_category.category_id
      WHERE dish.image_url IS NOT NULL
        AND dish.image_url <> ''
      ORDER BY RAND()
      LIMIT ${count}
    `);

    const grouped = rows.reduce((acc, row) => {
      if (!acc[row.id]) {
        acc[row.id] = {
          id: row.id,
          name: row.name,
          description: row.description,
          image: row.image_url,
          country: row.country_name,
          categories: []
        };
      }
      if (row.category_name) acc[row.id].categories.push(row.category_name);
      return acc;
    }, {});

    res.json(Object.values(grouped));
  } catch (error) {
    console.error("Random dish error:", error);
    res.status(500).json({ error: "Failed to fetch random dishes" });
  } finally {
    if (connection) connection.release();
  }
});



// Print server start message to console
app.listen(PORT, () => {
  console.log(`Server listening on http://localhost:${PORT}`);
});
