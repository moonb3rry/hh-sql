INSERT INTO employer (company_name, company_rating)
VALUES  ('hh.ru', 5.0),
        ('Яндекс', 4.6),
        ('Google', 4.9),
        ('Климпони', 4.2),
        ('IBM', 4.5),
        ('PuPu Inc.', 4.9);

INSERT INTO area(area_name)
VALUES ('Москва'),
       ('Санкт-Петербург'),
       ('Казань'),
       ('Калининград'),
       ('Екатеринбург');

INSERT INTO experience (experience_name)
VALUES ('Не имеет значения'),
       ('Без опыта'),
       ('От 1 года до 3 лет'),
       ('От 3 до 6 лет'),
       ('Более 6 лет');

INSERT INTO employment_type (employment_type_name)
VALUES  ('Полная занятость'),
        ('Частичная занятость'),
        ('Проектная работа'),
        ('Волонтерство'),
        ('Стажировка');

INSERT INTO specialization (specialization_name)
VALUES ('Аналитик'),
       ('Копирайтер'),
       ('Психолог'),
       ('Разработчик'),
       ('Тестировщик'),
       ('Экономист'),
       ('Инженер'),
       ('Юрист');

INSERT INTO work_schedule (work_schedule_name)
VALUES  ('Полный день'),
        ('Сменный график'),
        ('Гибкий график'),
        ('Удаленная работа'),
        ('Вахтовый метод');

WITH test_data (id, vacancy_name, specialization_id, employer_id, employment_type_id, work_schedule_id, experience_id,
    area_id, compensation_from, description, date_int) AS (
    SELECT generate_series(1,10000) AS id,
            md5(random()::text) AS vacancy_name,
           (((random()*10)::int) % 8) + 1 AS specialization_id,
           (((random()*10)::int) % 6) + 1 AS employer_id,
           (((random()*10)::int) % 5) + 1 AS employment_type_id,
           (((random()*10)::int) % 5) + 1 AS work_schedule_id,
           (((random()*10)::int) % 5) + 1 AS experience_id,
           (((random()*10)::int) % 5) + 1 AS area_id,
           round((random() * 100000)::int, -3) AS compensation_from,
           md5(random()::text) AS description,
           (random()*200)::int AS date_int
)
INSERT INTO vacancy(vacancy_name, specialization_id, employer_id, employment_type_id, work_schedule_id, experience_id,
                    area_id, compensation_from, compensation_to, description, publication_date)
SELECT vacancy_name, specialization_id, employer_id, employment_type_id, work_schedule_id, experience_id,
       area_id, compensation_from, compensation_from+10000, description, current_date-date_int
FROM test_data;

WITH test_data (id, specialization_id, applicant_id, employment_type_id, work_schedule_id,
    experience_id, compensation_from, area_id, description, date_int) AS (
    SELECT generate_series(1,100000) AS id,
           (((random()*10)::int) % 8) + 1 AS specialization_id,
           (((random()*10)::int) % 6) + 1 AS applicant_id,
           (((random()*10)::int) % 5) + 1 AS employment_type_id,
           (((random()*10)::int) % 5) + 1 AS work_schedule_id,
           (((random()*10)::int) % 5) + 1 AS experience_id,
           round((random() * 100000)::int, -3) AS compensation_from,
           (((random()*10)::int) % 5) + 1 AS area_id,
           md5(random()::text) AS description,
           (random()*200)::int AS date_int
)
INSERT INTO cv(specialization_id, applicant_id, employment_type_id,
               work_schedule_id, experience_id, compensation_from, compensation_to, area_id, description, publication_date)
SELECT specialization_id, applicant_id, employment_type_id,
       work_schedule_id, experience_id, compensation_from, compensation_from+10000, area_id, description, current_date-date_int
FROM test_data;

WITH test_data (id, vac_id, cv_id) AS (
    SELECT generate_series(1, 1000000) AS id,
           (((random() * 100000) ::int) % 10000) + 1 AS vac_id,
           (((random() * 1000000) ::int) % 100000) + 1 AS cv_id
)
INSERT INTO response (vacancy_id, cv_id, publication_date)
SELECT vacancy_id, cv_id, vac.publication_date + INTERVAL '1 day' * round(random() * 730)
FROM test_data test
INNER JOIN vacancy vac ON test.vac_id = vac.vacancy_id;
