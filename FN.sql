/*funcion que calcula el pbi total*/
delimiter //

create function calcular_pbi_total(habitantes_val int, pbi_per_capita_val decimal(10, 2)) returns decimal(20, 2) deterministic
begin
  declare pbi_total decimal(20, 2);
  
  set pbi_total = cast(habitantes_val as decimal(20, 2)) * cast(pbi_per_capita_val as decimal(10, 2));
  
  return pbi_total;
end;
//
delimiter


/*funcion que calcula el pbi real (per capita pero sobre la poblacion trabajadora)*/
delimiter //

create function pbi_per_capita_real(pais_nombre varchar(255)) returns decimal(10, 2) deterministic
begin
  declare pbi_per_capita_trabajador decimal(10, 2);
  declare habitantes_val int;
  declare pbi_per_capita_val decimal(10, 2);
  declare poblacion_trabajadora_val decimal(5, 2);
  
  select habitantes into habitantes_val
  from poblacion
  where id_poblacion = (select id_poblacion from paises where pais = pais_nombre);
  
  select pbi_per_capita into pbi_per_capita_val
  from t_pbi_per_capita
  where id_pbi = (select id_pbi from paises where pais = pais_nombre);
  
  select poblacion_trabajadora_redondeo into poblacion_trabajadora_val
  from trabajo
  where id_trabajo = (select id_trabajo from paises where pais = pais_nombre);
  
  set pbi_per_capita_trabajador = calcular_pbi_total(habitantes_val, pbi_per_capita_val) / habitantes_val;
  
  return pbi_per_capita_trabajador;
end;
//

delimiter ;

select pbi_per_capita_real('noruega') as pbi_per_capita_trabajador;
