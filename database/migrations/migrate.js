const fs = require("fs");
const path = require("path");
const { pool } = require("../../src/db");

async function runMigrations() {
  const folder = __dirname;
  const files = fs.readdirSync(folder).sort();

  for (const file of files) {
    const sql = fs.readFileSync(path.join(folder, file), "utf8");
    console.log(`Running migration: ${file}`);

    try {
      await pool.query(sql);
      console.log("✔ Migration applied successfully");
    } catch (err) {
      console.error(`❌ Migration failed: ${file}`, err);
      process.exit(1);
    }
  }
  process.exit();
}

runMigrations();
