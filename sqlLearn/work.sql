CREATE TABLE Collections (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(15) NOT NULL,
	year_release INT NOT NULL
);

CREATE TABLE Albums (
	album_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL ,
	year_release INT NOT NULL
);

CREATE TABLE Tracks (
	track_id SERIAL PRIMARY KEY,
    album_id INT,
	name VARCHAR NOT NULL,
	duration INT NOT NULL,
	FOREIGN KEY (album_id) REFERENCES Albums (album_id)
);

CREATE TABLE Genres (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL
);

CREATE TABLE Musician (
	musician_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE CollectionTrack (
    collectiontrack_id SERIAL PRIMARY KEY,
    collection_id INT,
    track_id INT,
	FOREIGN KEY (collection_id) REFERENCES Collections (collection_id),
	FOREIGN KEY (track_id) REFERENCES Tracks (track_id)
);

CREATE TABLE GenreMusician (
    genremusician_id SERIAL PRIMARY KEY,
    genre_id INT,
    musician_id INT,
    FOREIGN KEY (genre_id) REFERENCES Genres (genre_id),
    FOREIGN KEY (musician_id) REFERENCES Musician (musician_id)
);

CREATE TABLE MusicianAlbums (
    musicianalbums_id SERIAL PRIMARY KEY,
    musician_id INT,
    album_id INT,
    FOREIGN KEY (musician_id) REFERENCES Musician (musician_id),
    FOREIGN KEY (album_id) REFERENCES Albums (album_id)
);

INSERT INTO Musician (name)
VALUES
	('Imagine Dragons'),
	('Джерело'),
	('Цветень'),
	('Нервы');

INSERT INTO Genres (name)
VALUES
	('Рок'),
	('Поп-музыка'),
	('Народные песни');

INSERT INTO Albums (name, year_release)
VALUES
	('Десятилетие', 2011),
	('Imagine Dragons', 2015),
	('Альбом народных песен', 2022);

INSERT INTO Tracks (name, duration, album_id)
VALUES
 ('Гармонист', 4, 3),
 ('roots', 5, 2),
 ('the bast', 3, 1),
 ('Моя коляда', 6, 3),
 ('Im so sorry', 5, 2),
 ('Ишла дiвча', 3, 3);

INSERT INTO Collections (name, year_release)
VALUES
	('МЛП', 2023),
	('ID', 2005),
	('Собрник 2', 2010),
	('Собрник 3', 2015);
INSERT INTO CollectionTrack (collection_id, track_id)
VALUES
	(1, 1),
	(2, 3),
	(3, 5),
	(4, 6);

INSERT INTO GenreMusician (genre_id, musician_id)
VALUES
	(1, 1),
	(1, 4),
	(2, 4),
	(3, 2),
	(3, 3);

INSERT INTO MusicianAlbums (musician_id, album_id)
VALUES
	(1, 4),
	(2, 1),
	(3, 2),
	(3, 4);

SELECT name, duration
FROM Tracks
WHERE duration = (SELECT MAX(duration FROM Tracks));

SELECT name
FROM Tracks
WHERE duration >= 3.5;

SELECT name
FROM Collections
WHERE year_release BETWEEN 2020 AND 2018;

SELECT name
FROM Musician
WHERE name NOT LIKE '% %';

SELECT name
FROM Tracks
WHERE name LIKE '%Моя%' OR name LIKE '%My%';

SELECT g.name, COUNT(musician_id) from genremusician gm
JOIN genres g on g.genre_id = gm.genre_id
GROUP BY gm.genre_id, g.name;

-- задание 3, запрос 3
SELECT AVG(t.duration)
FROM Albums a
LEFT JOIN Tracks t  ON a.album_id = t.album_id
GROUP BY a.album_id;


-- задание 3, запрос 4
SELECT M.name
FROM Musician M
JOIN MusicianAlbums MA ON MA.musician_id = MA.musician_id
JOIN Albums A on A.album_id = MA.album_id
WHERE A.year_release != 2020;

-- задание 3, запрос 5
SELECT C.name
FROM Collections C
JOIN CollectionTrack CT ON C.collection_id = CT.collection_id
JOIN Tracks T ON CT.track_id = T.track_id
JOIN Albums A ON T.album_id = A.album_id
JOIN MusicianAlbums MA ON A.album_id = MA.album_id
JOIN Musician M on M.musician_id = MA.musician_id
WHERE 'Imagine Dragons' = M.name;






