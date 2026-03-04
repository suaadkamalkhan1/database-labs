-- Lab 1: Books Read Tracker
-- Author: Suaad
-- Date: 1st march,2026
CREATE TABLE books_read (
book_id SERIAL PRIMARY KEY,
title VARCHAR(200) NOT NULL,
author VARCHAR(100) NOT NULL,
category VARCHAR(50),
pages INTEGER CHECK (pages > 0),
date_finished DATE,
rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 5.0),
notes TEXT
);
INSERT INTO books_read (title, author, category, pages, date_finished, rating,
notes) VALUES
;
