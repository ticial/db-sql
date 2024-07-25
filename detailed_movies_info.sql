SELECT
    m.id AS ID,
    m.title AS Title,
    m.release_date AS "Release date",
    m.duration AS Duration,
    m.description AS Description,
    json_build_object(
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'url', f.url
    ) AS Poster,
    json_build_object(
        'ID', d.id,
        'First name', d.first_name,
        'Last name', d.last_name
    ) AS Director
FROM
    Movie m
JOIN
    File f ON m.poster_id = f.id
JOIN
    Person d ON m.director_id = d.id
JOIN
    Movie_Genre mg ON m.id = mg.movie_id
JOIN
    Genre g ON mg.genre_id = g.id
WHERE
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > 135  -- 2 hours 15 minutes = 135 minutes
    AND g.name IN ('Action', 'Drama')
GROUP BY
    m.id, m.title, m.release_date, m.duration, m.description, f.file_name, f.mime_type, f.url, d.id, d.first_name, d.last_name
ORDER BY
    m.release_date DESC;