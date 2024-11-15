const properties = require("./json/properties.json");
const users = require("./json/users.json");
const { Pool } = require("pg");

const pool = new Pool({
  user: "development",
  password: "development",
  host: "localhost",
  database: "lightbnb",
});

/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function (email) {
  return pool
    .query(`SELECT * FROM users where email = $1`, [email.toLowerCase()])
    .then((result) => {
      console.log(result.rows[0]);
      return result.rows[0];
    })
    .catch((err) => {
      console.log(err.message);
    });
};
/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function (id) {
  return pool
    .query(`SELECT * FROM users where id = $1`, [id])
    .then((result) => {
    //  console.log(result.rows[0]);
      return result.rows[0];
    })
    .catch((err) => {
    //  console.log(err.message);
    });
};
/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser = function (user) {
  const query = `
    INSERT INTO
     users (name, email, password)
    VALUES
      ($1, $2, $3)
    RETURNING *
  `;
  return pool
  .query(query, [user.name,user.email,user.password])
  .then((result) => {
  //  console.log(result.rows[0]);
    return result.rows[0];
  })
  .catch((err) => {
   // console.log(err.message);
  });

};
/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function (guest_id, limit = 10) {
  const query = `
  select properties.*, reservations.*, avg(property_reviews.rating) as average_rating
  from properties
  join reservations on reservations.property_id = properties.id
  join property_reviews on property_reviews.property_id = properties.id
  where reservations.guest_id = $1 and reservations.end_date < current_date 
  group by properties.id, reservations.id
  order by reservations.start_date asc
  limit $2;
  `;
  return pool
    .query(query, [guest_id,limit])
    .then((result) => {
     // console.log(result.rows);
      return result.rows;
    })
    .catch((err) => {
     // console.log(err.message);
    });
};
/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function (options, limit = 10) {
  // 1
  const queryParams = [];
  // 2
  let queryString = `
  SELECT properties.*, avg(property_reviews.rating) as average_rating
  FROM properties
  JOIN property_reviews ON properties.id = property_id
  `;

  // 3
  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `WHERE city LIKE $${queryParams.length} `;
  }

  if (options.owner_id) {
    queryParams.push(options.owner_id);
    if (queryParams.length === 1) {
      queryString += `WHERE owner_id = $${queryParams.length} `;
    } else {
      queryString += `and owner_id = $${queryParams.length} `;
    }
  }

  if (options.minimum_price_per_night) {
    queryParams.push(options.minimum_price_per_night);
    if (queryParams.length === 1) {
      queryString += `WHERE cost_per_night / 100 >= $${queryParams.length} `;
    } else {
      queryString += `and cost_per_night / 100 >= $${queryParams.length} `;
    }
  }

  if (options.maximum_price_per_night) {
    queryParams.push(options.maximum_price_per_night);
    if (queryParams.length === 1) {
      queryString += `WHERE cost_per_night / 100 <= $${queryParams.length} `;
    } else {
      queryString += `and cost_per_night / 100 <= $${queryParams.length} `;
    }
  }

  if (options.minimum_rating) {
    queryParams.push(options.minimum_rating);
    queryString += `
    GROUP BY properties.id
    having avg(property_reviews.rating) >= $${queryParams.length} 
    ORDER BY cost_per_night
    `;
  } else {
    queryString += `
    GROUP BY properties.id
    ORDER BY cost_per_night
    `;
  }

  // 4
  queryParams.push(limit);
  queryString += `
  LIMIT $${queryParams.length};
  `;

  // 5
  console.log(queryString, queryParams);

  // 6
  return pool.query(queryString, queryParams).then((res) => res.rows);
};
/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function (property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
};

module.exports = {
  getUserWithEmail,
  getUserWithId,
  addUser,
  getAllReservations,
  getAllProperties,
  addProperty,
};
