create table tbl_time(
	id int primary key,
    period varchar(15) NULL,
    day int NULL,
    month int NULL,
    year int NULL,
    weekday varchar(10) NULL
);

create table tbl_district(
	id int primary key,
    name varchar(50)
);

create table tbl_neighborhood(
	id int primary key,
    name varchar(50)
);

create table tbl_vertice(
	id int primary key,
    label int, 
    district_id int,
    neighborhood_id int,
    zone_id int
);

create table tbl_segment(
	id int primary key,
    oneway varchar(15) NULL,
    length varchar(50) NULL,
    final_vertice_id int NULL,
    start_vertice_id int NULL
);

create table tbl_crime(
	id int primary key,
    total_feminicide int,
    total_homicide int,
    total_felony_murder int,
    total_bodily_harm  int,
    total_theft_cellphone int, 
    total_armed_robbery_cellphone int,
    total_theft_auto int,
    total_armed_robbery_auto int,
    segment_id int, 
    time_id int
);

