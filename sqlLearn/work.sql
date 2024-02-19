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
	('Мои любимые песни', 2023),
	('Imagine Dragons', 2005),
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

SELECT COUNT(musician_id)
FROM MusicianAlbums ma
LEFT JOIN Musician m ON ma.musician_id = m.musician_id;

SELECT COUNT(track_id)
FROM Tracks t
LEFT JOIN Albums a ON t.track_id = a.album_id
WHERE year_release BETWEEN 2018 AND 2021;

SELECT name
FROM Musician
WHERE ,
LEFT JOIN Albums a on a.year_release = ma.year_release,







