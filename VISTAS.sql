
/*1*/

create view idiomas_en_el_mundo as
select paises.pais, continentes.continente, regiones.region, idiomas.idioma
from paises 
inner join regiones on paises.id_region = regiones.id_region
inner join idiomas on paises.id_idioma = idiomas.id_idioma
inner join continentes on paises.id_continente = continentes.id_continente
where idiomas.idioma like '%INGLES%';

select * from idiomas_en_el_mundo;


/*2*/

create view menor_tasa_desempleo as
select paises.pais, paises.capital, paises.id_continente, continentes.continente, poblacion.habitantes, trabajo.tasa_desempleo
from paises 
inner join continentes on paises.id_continente = continentes.id_continente
inner join poblacion on paises.id_poblacion = poblacion.id_poblacion
inner join trabajo on paises.id_trabajo = trabajo.id_trabajo
where trabajo.tasa_desempleo <= 2;

select * from menor_tasa_desempleo;


/*3*/
alter table poblacion add column promedio_de_vida decimal (10, 1);
update poblacion
inner join paises on paises.id_poblacion = poblacion.id_poblacion
set poblacion.promedio_de_vida = round((poblacion.esperanza_de_vida_m + poblacion.esperanza_de_vida_h) / 2, 1);


create view longevidad as
select continentes.continente, paises.pais, gobiernos.gobierno, moneda_oficial.moneda, poblacion.habitantes, sociedad.apoyo_social, esperanza_de_vida_m, esperanza_de_vida_h, poblacion.exp_vida_buena_salud, promedio_de_vida
from paises
inner join gobiernos on paises.id_gobierno = gobiernos.id_gobierno
inner join continentes on paises.id_continente = continentes.id_continente
inner join moneda_oficial on paises.id_moneda = moneda_oficial.id_moneda
inner join poblacion on paises.id_poblacion = poblacion.id_poblacion
inner join sociedad on paises.id_sociedad = sociedad.id_sociedad
where promedio_de_vida >= '80';

select * from longevidad;



/*4*/

create view indicadores_economicos_laborales as
select continentes.continente, regiones.region, paises.pais, gobiernos.gobierno, moneda_oficial.moneda, t_pbi_per_capita.pbi_per_capita, 
t_ipc.id_ipc,t_ipc.ipc_variacion_porcentaje, trabajo.poblacion_trabajadora_redondeo, trabajo.tasa_desempleo
from paises
inner join gobiernos on paises.id_gobierno = gobiernos.id_gobierno
inner join regiones on paises.id_region = regiones.id_region
inner join continentes on paises.id_continente = continentes.id_continente
inner join moneda_oficial on paises.id_moneda = moneda_oficial.id_moneda
inner join t_pbi_per_capita on paises.id_pbi = t_pbi_per_capita.id_pbi
inner join t_ipc on paises.id_ipc = t_ipc.id_ipc
inner join trabajo on paises.id_trabajo = trabajo.id_trabajo;

select * from indicadores_economicos_laborales;


/*5*/

create view vista_top_ranking as
select r.puntaje, c.continente, rg.region, p.pais, i.idioma, po.habitantes, po.promedio_de_vida,
       po.exp_vida_buena_salud, s.apoyo_social, s.libertad_en_decisiones, s.generosidad,
       s.percepcion_corrupcion, t.poblacion_trabajadora_redondeo, t.tasa_desempleo,
       pbi_per_capita_real(p.pais) as pbi_per_capita
from paises p
join ranking r on r.id_puntaje = p.id_puntaje
join continentes c on p.id_continente = c.id_continente
join regiones rg on p.id_region = rg.id_region
join idiomas i on p.id_idioma = i.id_idioma
join poblacion po on p.id_poblacion = po.id_poblacion
join sociedad s on p.id_sociedad = s.id_sociedad
join trabajo t on p.id_trabajo = t.id_trabajo
order by r.puntaje desc
limit 10;

select * from vista_top_ranking;
