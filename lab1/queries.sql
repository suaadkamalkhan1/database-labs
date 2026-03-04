-- Lab 1: Analytical Queries
-- Author: Suaad Kamal Khan

SELECT title, author, rating
FROM books_read
ORDER BY rating DESC;

SELECT category, AVG(pages) as avg_pages
FROM books_read
GROUP BY category;

