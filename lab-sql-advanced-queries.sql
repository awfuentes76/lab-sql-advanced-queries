-- Lab | SQL Advanced queries
-- In this lab, you will be using the Sakila database of movie rentals.
-- Instructions
-- List each pair of actors that have worked together.

SELECT 
    fa1.actor_id AS actor_id1,
    a1.first_name AS actor_first_name1,
    a1.last_name AS actor_last_name1,
    fa2.actor_id AS actor_id2,
    a2.first_name AS actor_first_name2,
    a2.last_name AS actor_last_name2
FROM 
    film_actor fa1
JOIN 
    film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN 
    actor a1 ON fa1.actor_id = a1.actor_id
JOIN 
    actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY 
    fa1.actor_id, fa2.actor_id;

-- For each film, list actor that has acted in more films.

SELECT 
    sub.film_id,
    sub.actor_id,
    a.first_name,
    a.last_name,
    sub.film_count
FROM (
    SELECT 
        fa.film_id,
        fa.actor_id,
        COUNT(*) OVER (PARTITION BY fa.film_id ORDER BY COUNT(*) DESC) as rnk,
        COUNT(*) as film_count
    FROM film_actor fa
    GROUP BY fa.film_id, fa.actor_id
    ORDER BY fa.film_id, COUNT(*) DESC
) AS sub
JOIN actor a ON sub.actor_id = a.actor_id
WHERE sub.rnk = 1;


