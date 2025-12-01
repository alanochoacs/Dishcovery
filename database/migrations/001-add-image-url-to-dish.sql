try {
  await connection.execute(`
    ALTER TABLE dish ADD COLUMN image_url VARCHAR(255) NULL
  `);
  console.log("Column image_url added to dish table!");
} catch (err) {
  if (err.code === "ER_DUP_FIELDNAME") {
    console.log("Column image_url already exists — skipping.");
  } else {
    throw err; // real error
  }
}
