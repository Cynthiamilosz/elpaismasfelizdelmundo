
/*transacciones, stored procedures, triggers y creacion de usuarios*/

/*REGISTRO DE SESIONES*/
create table registro_sesiones (
  id_sesion int auto_increment  primary key,
  usuario varchar(100),
  fecha_inicio datetime,
  fecha_fin datetime,
  duracion time
);

delimiter //
create procedure InsertarRegistroSesion(in usuario varchar(100), in fecha_inicio datetime, in fecha_fin datetime)
begin
  declare duracion_val time;
  set duracion_val = timediff(fecha_fin, fecha_inicio);

  insert into registro_sesiones (usuario, fecha_inicio, fecha_fin, duracion) 
  values (usuario, fecha_inicio, fecha_fin, duracion_val);
end;
//
delimiter ;


delimiter //
create trigger trigger_insert_registro_sesion
after insert on registro_sesiones
for each row
begin
  if new.usuario is not null then
    insert into registro_acciones (accion_realizada, usuario)
    values ('Nueva sesión registrada', new.usuario);
  end IF;
end;
//
delimiter ;




/*REGISTRO DE ACCIONES*/
create table registro_acciones (
  id_registro int auto_increment  primary key,
  fecha_hora timestamp default current_timestamp,
  accion_realizada varchar(255),
  usuario varchar(100)
);


delimiter //
create procedure InsertarRegistroAccion(in accion varchar(255), in usuario varchar(100))
begin
insert into registro_acciones (accion_realizada, usuario) values (accion, usuario);
end;
//
delimiter ;


DELIMITER //
create trigger trigger_insert_registro_accion
after insert on registro_acciones
for each row
begin
 insert into registro_sesiones (usuario, fecha_inicio, fecha_fin, duracion)
  values (new.usuario, now(), now(), '00:00:00');
end;
//
delimiter ;

/*DROP TRIGGER IF EXISTS trigger_insert_registro_accion;*/


/*cear el usuario con permisos de solo lectura*/

create user 'usuario_solo_lectura'@'localhost' identified by 'lectura1';

/*asignar permisos de solo lectura sobre todas las tablas*/
grant select on worldhappinessreport2023.* to 'usuario_solo_lectura'@'localhost';

/*prohibir permisos de eliminación en todas las tablas*/
revoke delete on worldhappinessreport2023.* from 'usuario_solo_lectura'@'localhost';

rename user 'usuario_solo_lectura'@'localhost' to 'SoloLectura';

/*drop user 'SoloLectura';*/
SHOW GRANTS FOR 'SoloLectura';
SELECT User FROM mysql.user WHERE User = 'usuario_solo_lectura' AND Host = 'localhost';



-----------------------------------------------------------------


/*crear el usuario con permisos de lectura, inserción y modificación*/
create user 'usuario_modificacion'@'localhost' identified by 'modificacion1';

/*asignar permisos de lectura, inserción y modificación sobre todas las tablas*/
grant select, insert, update on worldhappinessreport2023.* to 'usuario_modificacion'@'localhost';

/*prohibir permisos de eliminación en todas las tablas*/
revoke delete on worldhappinessreport2023.* from 'usuario_modificacion'@'localhost';

rename user 'usuario_modificacion'@'localhost' to 'LecturayModificacion';

/*drop user 'lectura y modificacion';*/

SHOW GRANTS FOR 'LecturayModificacion';