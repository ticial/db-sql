SELECT 
    m.id AS "ID",
    m.title AS "Title",
    COUNT(mca.actor_id) AS "Actors count"
FROM 
    Movie m
JOIN 
    Movie_Character_Actor mca ON m.id = mca.movie_id
WHERE 
    m.release_date >= (CURRENT_DATE - INTERVAL '5 years')
GROUP BY 
    m.id, m.title
ORDER BY 
    "Actors count" DESC;