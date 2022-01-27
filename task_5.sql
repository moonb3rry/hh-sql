SELECT v.vacancy_id, v.vacancy_name
FROM vacancy v
        INNER JOIN response r on v.vacancy_id = r.vacancy_id
WHERE DATE(r.publication_date) - DATE(v.publication_date) <= 7
GROUP BY v.vacancy_id, v.vacancy_name
HAVING count(r.vacancy_id) > 5
ORDER BY v.vacancy_id