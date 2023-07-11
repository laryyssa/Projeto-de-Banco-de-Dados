create table tbl_time(
	id int primary key,
    period varchar(15) NULL,
    `day` int NULL,
    `month` int NULL,
    `year` int NULL,
    `weekday` varchar(10) NULL
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
    -- foreign key (district_id) references tbl_district(id),
    -- foreign key (neighborhood_id) references tbl_neighborhood(id)
);

create table tbl_segment(
	id int primary key,
    oneway varchar(15) NULL,
    length varchar(50) NULL,
    final_vertice_id int NULL,
    start_vertice_id int NULL
    -- foreign key (final_vertice_id) references tbl_vertice(id),
    -- foreign key (start_vertice_id) references tbl_vertice(id)
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

ALTER TABLE tbl_crime
MODIFY id INT PRIMARY KEY;

ALTER TABLE tbl_crime
ADD CONSTRAINT segment_id FOREIGN KEY (segment_id) REFERENCES tbl_segment(id);

ALTER TABLE tbl_crime
ADD CONSTRAINT time_id FOREIGN KEY (time_id) REFERENCES tbl_time(id);

-- Remova a restrição da chave primária
ALTER TABLE tbl_district DROP CONSTRAINT id;

-- Remova a restrição da chave estrangeira
ALTER TABLE tbl_crime DROP CONSTRAINT time_id;

DROP TABLE tbl_neighborhood
