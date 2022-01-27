SELECT vacancy_month AS vacancy_month,
       cv_month AS cv_month
FROM (
         SELECT EXTRACT(MONTH FROM publication_date) AS vacancy_month,
                count(*) AS count
         FROM vacancy
         GROUP BY vacancy_month
         ORDER BY count DESC
         LIMIT 1
     ) AS v
         INNER JOIN (
    SELECT EXTRACT(MONTH FROM publication_date) AS cv_month,
           count(*) AS count
    FROM cv
    GROUP BY cv_month
    ORDER BY count DESC
    LIMIT 1
) as c ON true;