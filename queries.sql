/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- update the animals table by setting the species column to unspecified then rollback
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


BEGIN;
-- Update the animals table, setting the species column to 'digimon' for animals with names ending in 'mon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update the animals table, setting the species column to 'pokemon' for animals without a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- All required actions
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

-- queries to answer the all questions:
SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS never_tried_escape
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;


--Vet clinic database: add "join table" for visits exercise:
SELECT a.name AS animal_name
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets ve ON ve.id = v.vet_id
WHERE ve.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS num_animals
FROM visits v
INNER JOIN vets ve ON ve.id = v.vet_id
WHERE ve.name = 'Stephanie Mendez';

SELECT v.name AS vet_name, s.name AS specialty_name
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name AS animal_name
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets ve ON ve.id = v.vet_id
WHERE ve.name = 'Stephanie Mendez'
  AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT a.name AS animal_name, v.visit_date
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets ve ON ve.id = v.vet_id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT a.name AS animal_name, v.visit_date, ve.name AS vet_name
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets ve ON ve.id = v.vet_id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS num_visits
FROM visits v
INNER JOIN vets ve ON ve.id = v.vet_id
INNER JOIN specializations s ON ve.id = s.vet_id
INNER JOIN species sp ON sp.id = s.species_id
WHERE sp.id != v.animal_id;

SELECT a.species_id, COUNT(*) AS visit_count, sp.name AS species_name
FROM visits v
INNER JOIN vets ve ON ve.id = v.vet_id
INNER JOIN animals a ON a.id = v.animal_id
INNER JOIN species sp ON sp.id = a.species_id
WHERE ve.name = 'Maisy Smith'
GROUP BY a.species_id, sp.name
ORDER BY visit_count DESC
LIMIT 1;