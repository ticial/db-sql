SELECT
    u.id AS ID,
    u.username AS Username,
    array_agg(fm.movie_id) AS "Favorite movie IDs"
FROM
    "User" u
LEFT JOIN
    Favorite_Movie fm ON u.id = fm.user_id
GROUP BY
    u.id, u.username
ORDER BY
    u.id;