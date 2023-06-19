/* Database schema to keep the structure of entire database. */

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

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    age INT,
    date_of_graduatioin DATE
);

CREATE TABLE specializations (
    vet_id INT, 
    species_id INT,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id),
    CONSTRAINT pk_vet_species PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animal_id INT, 
    vet_id INT,
    visit_date DATE,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX ids_visits_animal_id ON visits(animal_id);

CREATE INDEX ids_visits_vet_id ON visits(vet_id ASC);

CREATE INDEX ids_owners_email ON owners(email);
