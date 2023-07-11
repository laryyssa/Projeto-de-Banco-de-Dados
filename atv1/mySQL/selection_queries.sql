-- indices

CREATE INDEX idx_ano ON tbl_time(year) USING HASH;
DROP INDEX idx_ano ON tbl_time;
SHOW TABLE STATUS LIKE 'tbl_time';
show engines;


create index idx_nome_dist on tbl_district(name) using HASH;
create index idx_nome_bairro on tbl_neighborhood(name) using HASH;

-- 1. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016?

explain
select 
    sum(c.total_feminicide),
    sum(c.total_homicide),
    sum(c.total_felony_murder),
    sum(c.total_bodily_harm),
    sum(c.total_theft_cellphone),
    sum(c.total_armed_robbery_cellphone),
    sum(c.total_theft_auto),
    sum(c.total_armed_robbery_auto),
    c.segment_id
from tbl_crime c
inner join tbl_segment s on c.segment_id = s.id
inner join tbl_vertice v1 on s.start_vertice_id = v1.id 
inner join tbl_vertice v2 on s.final_vertice_id = v2.id
inner join tbl_district d1 on v1.district_id = d1.id
inner join tbl_district d2 on v2.district_id = d2.id
inner join tbl_time t on c.time_id = t.id
where 
	(d1.name = 'IGUATEMI' and d2.name = 'IGUATEMI')  and
    (t.year = 2016)
group by 
	c.segment_id;

-- 2. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016?

explain
select 
    sum(total_feminicide),
    sum(total_homicide),
    sum(total_felony_murder),
    sum(total_bodily_harm),
    sum(total_theft_cellphone),
    sum(total_armed_robbery_cellphone),
    sum(total_theft_auto),
    sum(total_armed_robbery_auto),
    segment_id
from tbl_crime c
inner join tbl_segment s on c.segment_id = s.id
inner join tbl_vertice v1 on s.start_vertice_id = v1.id 
inner join tbl_vertice v2 on s.final_vertice_id = v2.id 
inner join tbl_district d1 on v1.district_id = d1.id
inner join tbl_district d2 on v2.district_id = d2.id
inner join tbl_time t on c.time_id = t.id
where 
	(d1.name = 'IGUATEMI' and  d2.name = 'IGUATEMI')  and
    (t.year >= 2006 and t.year <= 2016)
group by 
	c.segment_id;

-- 3. Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015?

explain
select 
	sum(total_theft_cellphone),
    sum(total_armed_robbery_cellphone),
    sum(total_theft_auto),
    sum(total_armed_robbery_auto)
from tbl_crime c
inner join tbl_segment s on c.segment_id = s.id
inner join tbl_vertice v1 on s.final_vertice_id = v1.id
inner join tbl_vertice v2 on s.start_vertice_id = v2.id
inner join tbl_neighborhood n1 on v1.neighborhood_id = n1.id
inner join tbl_neighborhood n2 on v2.neighborhood_id = n2.id
inner join tbl_time t on c.time_id = t.id
where
	(n1.name LIKE 'SANTA EFIG%' and n2.name LIKE 'SANTA EFIG%') and
    (t.year = 2015);
    

-- 4. Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012?

explain
SELECT 
    sum(total_feminicide),
    sum(total_homicide),
    sum(total_felony_murder),
    sum(total_bodily_harm),
    sum(total_theft_cellphone),
    sum(total_armed_robbery_cellphone),
    sum(total_theft_auto),
    sum(total_armed_robbery_auto)
from tbl_crime c
inner join tbl_segment s on c.segment_id = s.id
inner join tbl_time t on c.time_id = t.id
where
	(oneway = 'yes') and
    (t.year = 2012);
    
-- 5. Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017?

explain
select 
	sum(total_theft_cellphone),
    sum(total_armed_robbery_cellphone),
    sum(total_theft_auto),
    sum(total_armed_robbery_auto),
    c.segment_id
from tbl_crime c
 -- inner join tbl_segment s on c.segment_id = s.id
-- inner join tbl_vertice v1 on s.final_vertice_id = v1.id
-- inner join tbl_vertice v2 on s.start_vertice_id = v2.id
-- inner join tbl_neighborhood n1 on v1.neighborhood_id = n1.id
-- inner join tbl_neighborhood n2 on v2.neighborhood_id = n2.id
inner join tbl_time t on c.time_id = t.id
where
	(t.year = 2017)
group by
	c.segment_id;

-- 6. Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes), 
-- durante o mês de Novembro de 2010?

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

explain
select 
	segment_id
from tbl_crime c
inner join tbl_time t on c.time_id = t.id
where
	(t.month = 11) and
    (t.year = 2010)
group by c.segment_id
order by (total_feminicide + total_homicide + total_felony_murder + 
		  total_bodily_harm + total_theft_cellphone + total_theft_auto ) DESC;

-- 7. Quais os IDs dos segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes) 
-- durante os finais de semana do ano de 2018?

explain
select 
	segment_id
from tbl_crime c
inner join tbl_time t on c.time_id = t.id
where
	(t.weekday = 'saturday' or t.weekday = 'sunday') and
    (t.year = 2018)
group by c.segment_id
order by (c.total_feminicide + c.total_homicide + c. total_felony_murder + 
		  c.total_bodily_harm + c.total_theft_cellphone + c.total_theft_auto ) DESC;









