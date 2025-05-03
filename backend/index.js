const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

db.connect((err) => {
  if (err) {
    console.error('DB connection failed:', err.stack);
    return;
  }
  console.log('Connected to MySQL DB');
});

app.get('/', (req, res) => {
  res.send('Welcome to E-Commerce Backend');
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
