DROP TABLE IF EXISTS response;
DROP TABLE IF EXISTS cv;
DROP TABLE IF EXISTS applicant;
DROP TABLE IF EXISTS vacancy;
DROP TABLE IF EXISTS specialization;
DROP TABLE IF EXISTS area;
DROP TABLE IF EXISTS work_schedule;
DROP TABLE IF EXISTS employment_type;
DROP TABLE IF EXISTS employer;
DROP TABLE IF EXISTS experience;

CREATE TABLE employer(
  employer_id SERIAL PRIMARY KEY,
  company_name TEXT NOT NULL,
  company_rating FLOAT NOT NULL
);

CREATE TABLE work_schedule(
    work_schedule_id SERIAL PRIMARY KEY,
    work_schedule_name TEXT NOT NULL
);

CREATE TABLE employment_type(
    employment_type_id SERIAL PRIMARY KEY,
    employment_type_name TEXT NOT NULL
);

CREATE TABLE specialization (
    specialization_id SERIAL PRIMARY KEY,
    specialization_name TEXT NOT NULL
);

CREATE TABLE area(
  area_id SERIAL PRIMARY KEY,
  area_name TEXT NOT NULL
);

CREATE TABLE experience(
    experience_id SERIAL PRIMARY KEY,
    experience_name TEXT NOT NULL
);

CREATE TABLE vacancy (
    vacancy_id SERIAL PRIMARY KEY,
    vacancy_name TEXT NOT NULL,
    specialization_id INTEGER NOT NULL REFERENCES specialization(specialization_id),
    employer_id INTEGER NOT NULL REFERENCES employer(employer_id),
    employment_type_id INTEGER NOT NULL REFERENCES employment_type(employment_type_id),
    work_schedule_id INTEGER NOT NULL REFERENCES work_schedule(work_schedule_id),
    experience_id INTEGER NOT NULL REFERENCES experience(experience_id),
    area_id INTEGER NOT NULL REFERENCES area(area_id),
    compensation_from INTEGER,
    compensation_to INTEGER,
    compensation_gross BOOLEAN,
    description TEXT NOT NULL,
    publication_date TIMESTAMP
);

CREATE TABLE cv (
    cv_id SERIAL PRIMARY KEY,
    specialization_id INTEGER NOT NULL REFERENCES specialization(specialization_id),
    applicant_id INTEGER NOT NULL,
    employment_type_id INTEGER NOT NULL REFERENCES employment_type(employment_type_id),
    work_schedule_id INTEGER NOT NULL REFERENCES work_schedule(work_schedule_id),
    experience_id INTEGER NOT NULL REFERENCES experience(experience_id),
    compensation_from INTEGER,
    compensation_to INTEGER,
    area_id INTEGER NOT NULL REFERENCES area(area_id),
    description TEXT NOT NULL,
    publication_date TIMESTAMP
);

CREATE TABLE response(
    response_id SERIAL PRIMARY KEY,
    cv_id INTEGER NOT NULL REFERENCES cv(cv_id),
    vacancy_id INTEGER NOT NULL REFERENCES vacancy(vacancy_id),
    publication_date TIMESTAMP
);
