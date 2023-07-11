-- time

COPY tbl_time (id, period, day, month, year, weekday)
FROM 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\time.csv'
DELIMITER ';'
CSV HEADER;

-- district

create temporary table t_district(
	id int primary key,
	name varchar(50),
	geometry text
)

COPY t_district (id, name, geometry)
FROM 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\district.csv'
DELIMITER ';'
CSV HEADER;

insert into tbl_district (id, name)
select id, name
from t_district

-- neighborhood

create temporary table t_neighborhood(
	id int primary key,
	name varchar(50),
	geometry text
);

COPY t_neighborhood (id, name, geometry)
FROM 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\neighborhood.csv'
DELIMITER ';'
CSV HEADER;

insert into tbl_neighborhood (id, name)
select id, name
from t_neighborhood;

-- vertice

COPY tbl_vertice (id, label, district_id, neighborhood_id, zone_id)
FROM 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\vertice.csv'
DELIMITER ';'
CSV HEADER;

-- segment

create temporary table t_segment(
	id int primary key,
	geometry text,
	oneway varchar (15),
	length varchar(50),
	final_vertice_id int,
	start_vertice_id int
);

COPY t_segment (id, geometry, oneway, length, final_vertice_id, start_vertice_id)
FROM 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\segment.csv'
DELIMITER ';'
CSV HEADER;

insert into tbl_segment (id, oneway, final_vertice_id, start_vertice_id)
select id, oneway, final_vertice_id, start_vertice_id
from t_segment;

-- crime

COPY tbl_crime 
FROM 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\crime.csv'
DELIMITER ';'
CSV HEADER;



