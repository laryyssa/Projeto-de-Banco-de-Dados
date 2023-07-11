show variables like 'secure_file_priv';

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\time.csv'
into table tbl_time
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(id, period, @day, @month, @year, weekday)
SET `day` = NULLIF(TRIM(@day), ''),
    `month` = NULLIF(TRIM(@month), ''),
    `year` = NULLIF(TRIM(@year), '');
    
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\district.csv'
into table tbl_district
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(id, name, @dummy)
SET id = id, name = name;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\neighborhood.csv'
into table tbl_neighborhood
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(id, name, @dummy)
SET id = id, name = name;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\vertice.csv'
into table tbl_vertice
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\segment.csv'
into table tbl_segment
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(id, @dummy, oneway, @length, final_vertice_id, start_vertice_id)
SET id = id, oneway = oneway, length = NULLIF(TRIM(@length), ''), final_vertice_id = final_vertice_id, start_vertice_id = start_vertice_id;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\crime.csv'
into table tbl_crime
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
