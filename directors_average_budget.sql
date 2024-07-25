SELECT
    d.id AS "Director ID",
    CONCAT(d.first_name, ' ', d.last_name) AS "Director name",
    AVG(m.budget) AS "Average budget"
FROM
    Person d
JOIN
    Movie m ON d.id = m.director_id
GROUP BY
    d.id, d.first_name, d.last_name
ORDER BY
    "Average budget" DESC;