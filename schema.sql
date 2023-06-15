/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS(
   ID INT PRIMARY KEY NOT NULL,
   NAME TEXT NOT NULL,
   DATE_OF_BIRTH DATE NOT NULL,
   ESCAPE_ATTEMPTS INT NOT NULL,
   NEUTERED BOOLEAN,
   WEIGHT_KG DECIMAL,
   SPECIES VARCHAR(255)
);
CREATE TABLE ANIMALS (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species_id INTEGER REFERENCES species(id),
    owner_id INTEGER REFERENCES owners(id)
);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR
);