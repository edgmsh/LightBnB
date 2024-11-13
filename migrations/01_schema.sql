DROP TABLE IF EXISTS property_reviews CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id int NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description text,
  thumbnail_photo_url VARCHAR(255) NOT NULL,
  cover_photo_url VARCHAR(255) NOT NULL,
  cost_per_night int NOT NULL DEFAULT 0,
  parking_spaces int NOT NULL DEFAULT 0,
  number_of_bathrooms int NOT NULL DEFAULT 0,
  number_of_bedrooms int NOT NULL DEFAULT 0,
  country VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  property_id int NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  guest_id int NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY NOT NULL,
  guest_id int NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  property_id int NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  reservation_id int NOT NULL REFERENCES reservations(id) ON DELETE CASCADE,
  rating smallint NOT NULL DEFAULT 0,
  message text
);