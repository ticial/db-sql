SELECT 
    p.id AS "ID",
    p.first_name AS "First name",
    p.last_name AS "Last name",
    SUM(m.budget) AS "Total movies budget"
FROM 
    Person p
JOIN 
    Movie_Character_Actor mca ON p.id = mca.actor_id
JOIN 
    Movie m ON mca.movie_id = m.id
GROUP BY 
    p.id, p.first_name, p.last_name
ORDER BY 
    "Total movies budget" DESC;