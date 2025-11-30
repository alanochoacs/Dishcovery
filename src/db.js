const mysql = require("mysql2/promise"); // MySQL client with promises

require("dotenv").config();

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USERNAME || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "DISHCOVERY_DEV",
  waitForConnections: true, // If true, the pool will queue connection requests when no connection is available.
  connectionLimit: 10, // Maximum number of connections in the pool
  queueLimit: 0,
});

module.exports = { pool };
