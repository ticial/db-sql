SELECT
    m.id AS ID,
    m.title AS Title,
    m.release_date AS "Release date",
    m.duration AS Duration,
    m.description AS Description,
    json_build_object(
        'file_name', pf.file_name,
        'mime_type', pf.mime_type,
        'url', pf.url,
        'is_public', f.is_public
    ) AS Poster,
    json_build_object(
        'ID', d.id,
        'First name', d.first_name,
        'Last name', d.last_name,
        'Photo', json_build_object(
            'file_name', dp.file_name,
            'mime_type', dp.mime_type,
            'url', dp.url,
            'is_public', f.is_public
        )
    ) AS Director,
    json_agg(
        json_build_object(
            'ID', a.id,
            'First name', a.first_name,
            'Last name', a.last_name,
            'Photo', json_build_object(
                'file_name', ap.file_name,
                'mime_type', ap.mime_type,
                'url', ap.url,
                'is_public', f.is_public
            )
        )
    ) AS Actors,
    json_agg(
        json_build_object(
            'ID', g.id,
            'Name', g.name
        )
    ) AS Genres
FROM
    Movie m
JOIN
    File pf ON m.poster_id = pf.id
JOIN
    Person d ON m.director_id = d.id
JOIN
    File dp ON d.primary_photo_id = dp.id
LEFT JOIN
    Movie_Character_Actor mca ON m.id = mca.movie_id
LEFT JOIN
    Person a ON mca.actor_id = a.id
LEFT JOIN
    File ap ON a.primary_photo_id = ap.id
LEFT JOIN
    Movie_Genre mg ON m.id = mg.movie_id
LEFT JOIN
    Genre g ON mg.genre_id = g.id
WHERE
    m.id = 1
GROUP BY
    m.id, m.title, m.release_date, m.duration, m.description, pf.file_name, pf.mime_type, pf.url, d.id, d.first_name, d.last_name, dp.file_name, dp.mime_type, dp.url
ORDER BY
    m.title;