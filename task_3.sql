SELECT
    ROUND(AVG(compensation_from), 2) AS average_compensation_from,
    ROUND(AVG(compensation_to), 2) AS average_compensation_to,
    ROUND(AVG((compensation_to + compensation_from) / 2), 2) AS average_from_to
FROM vacancy
GROUP BY area_id
ORDER BY area_id;