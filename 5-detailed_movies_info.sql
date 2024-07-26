SELECT 
    m.id AS "ID",
    m.title AS "Title",
    m.release_date AS "Release date",
    m.duration AS "Duration",
    m.description AS "Description",
    json_build_object(
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'url', f.url,
        'is_public', f.is_public
    ) AS "Poster",
    json_build_object(
        'ID', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name
    ) AS "Director"
FROM 
    Movie m
JOIN 
    Country c ON m.country_id = c.id
JOIN 
    Movie_Genre mg ON m.id = mg.movie_id
JOIN 
    Genre g ON mg.genre_id = g.id
JOIN 
    File f ON m.poster_id = f.id
JOIN 
    Person p ON m.director_id = p.id
WHERE 
    c.id = 1 AND
    m.release_date >= '2022-01-01' AND
    m.duration > (2 * 60 + 15) AND
    g.name IN ('Action', 'Drama')
GROUP BY 
    m.id, f.id, p.id
ORDER BY 
    m.release_date DESC;