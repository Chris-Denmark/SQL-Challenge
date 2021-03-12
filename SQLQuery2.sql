--SELECT
--    Id,
--    Title,
--    SongLength,
--    ReleaseDate,
--    GenreId,
--    ArtistId,
--    AlbumId
--FROM Song;

--SELECT
--    Id,
--    Title,
--    ReleaseDate
--FROM Song;

--SELECT * FROM Song;

--SELECT
--    Id,
--    Title,
--    SongLength,
--    ReleaseDate,
--    GenreId,
--    ArtistId,
--    AlbumId
--FROM Song
--WHERE SongLength > 100;

--SELECT s.Title,
--       a.ArtistName
--  FROM Song s
--       LEFT JOIN Artist a on s.ArtistId = a.id;

--INSERT INTO Genre (Label) VALUES ('Techno');

--select SongLength from Song where Id = 18;


--update Song
--set SongLength = 515
--where Id = 18;

---- Once you run the update statement, in order to make sure the value has changed, we run the select query again.
--select SongLength from Song where Id = 18;

--delete from Song where Id = 18;

--1.Using the SQL Server Object Explorer in Visual Studio, examine the tables, columns, and foreign keys of the database.

SELECT * 
FROM Genre;

--2.Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords.

select *
from artist ar
order by ar.ArtistName;

--3.Write a SELECT query that lists all the songs in the Song table and include the Artist name.

select 
 s.title,
 ar.artistName
from song s
left join artist ar on s.artistId = ar.Id

--4.Write a SELECT query that lists all the Artists that have a Pop Album

select distinct 
 ar.Id, ar.ArtistName as 'Artist Name' 
  from artist ar left join album al on al.ArtistId = ar.Id 
  left join genre g on al.GenreId = g.Id 
   where g.Label = 'Pop'

--5. write a select query that lists all the artists that have a jazz or rock album

select distinct 
 ar.Id, ar.ArtistName as 'Artist Name' 
  from artist ar left join album al on al.ArtistId = ar.Id 
  left join genre g on al.GenreId = g.Id 
   where g.Label = 'Jazz'or g.label = 'Rock'

--6. Write a SELECT statement that lists the Albums with no songs

select 
 al.Title 
  from album al left join song s on al.Id = s.AlbumId
   where s.Id is null

--7.Using the INSERT statement, add one of your favorite artists to the Artist table.

insert into Artist (ArtistName, YearEstablished) VALUES ('Panic! at the disco', 2004)

--8.Using the INSERT statement, add one, or more, albums by your artist to the Album table.

INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Death Of A Bachelor', '1/15/2016', 2166, 'Fueled By Ramen', 28, 7);

--9.Using the INSERT statement, add some songs that are on that album to the Song table.

INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Hallelujah', 180, '04/20/2015', 7, 28, 23);

--10.Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

select 
 s.title as 'Song Title', al.Title as 'Album Title', ar.ArtistName as 'Artist Name'
  from song s left join album al on al.Id = s.AlbumId
  left join artist ar on ar.Id = al.ArtistId
   where ar.ArtistName = 'Panic! at the disco'

--11.Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

select
    al.Title as 'Album Title',
    count(s.Title) as 'Number of Songs'
from Album al
left join Song s on al.Id = s.AlbumId
group by al.Title

--12.Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

select 
    ar.ArtistName as 'Artist Name',
    count(s.title) as 'Number of Songs'
from artist ar
left join Song s on ar.id = s.ArtistId
group by ar.ArtistName

--13.Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

select 
    g.label as 'Genre',
    count(s.title) as 'Number of Songs'
from genre g
left join Song s on g.id = s.GenreId
group by g.label

--14.Write a SELECT query that lists the Artists that have put out records on more than one record label. Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword

select
    ar.ArtistName as 'Artist Name',
    count(distinct al.Label) as 'Number of Labels'
from Artist ar
left join Album al on al.ArtistId = ar.Id
group by ar.ArtistName
having count(distinct al.Label) > 1

--15.Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
  
select
    Title as 'Album Title',
    AlbumLength as 'Album Length'
from Album
where AlbumLength = (select max(AlbumLength) from Album)

--16.Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.

select
    Title as 'Song Title',
    SongLength as 'Song Length'
from Song
where SongLength = (select max(SongLength) from Song)

--17.Modify the previous query to also display the title of the album.

select
    s.Title as 'Song Title',
    s.SongLength as 'Song Length',
    a.Title as 'Album Title'
from Song s
left join Album a on a.Id = s.AlbumId
where s.SongLength = (select max(SongLength) from Song);