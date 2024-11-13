CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255),
  password VARCHAR(255)
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  owner_id int NOT NULL REFERENCES users(id),
  title VARCHAR(255),
  description text,
  thumbnail_photo_url VARCHAR(255),
  cover_photo_url VARCHAR(255),
  cost_per_night int,
  parking_spaces int,
  number_of_bathrooms int,
  number_of_bedrooms int,
  country VARCHAR(255),
  street VARCHAR(255),
  city VARCHAR(255),
  province VARCHAR(255),
  post_code VARCHAR(255),
  active BOOLEAN
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  start_date date,
  end_date date,
  property_id int NOT NULL REFERENCES properties(id),
  guest_id int NOT NULL REFERENCES users(id)
);

CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY,
  guest_id int NOT NULL REFERENCES users(id),
  property_id int NOT NULL REFERENCES properties(id),
  reservation_id int NOT NULL REFERENCES reservations(id),
  rating smallint,
  message text
);