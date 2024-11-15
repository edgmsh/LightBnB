const pg = require("pg");
const { Pool } = pg;

const client = new Pool({
  user: "development",
  password: "development",
  host: "localhost",
  database: "lightbnb",
});

module.exports = {client};