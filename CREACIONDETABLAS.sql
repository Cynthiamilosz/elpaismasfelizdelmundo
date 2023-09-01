create schema WorldHappinessReport2023;
use paises_del_mundo;

create table continentes (id_continente int not null auto_increment,
						  continente varchar (10),
                          paises_por_continente int,
                          primary key (id_continente));
                          
create table educacion (id_educacion int not null auto_increment,
						  matricula_ed_primaria decimal (10,1),
                          matricula_ed_terciaria decimal (10,1),
                          primary key (id_educacion));   
                          
create table gobiernos (id_gobierno int not null auto_increment,
						gobierno varchar (100),
                        primary key (id_gobierno));                          

create table idiomas (id_idioma int not null auto_increment,
				      idioma varchar (60),
                      primary key (id_idioma));

create table t_ipc (id_ipc int not null auto_increment,
				          c_ipc decimal (10,2),
                          ipc_variacion_porcentaje decimal (10,1),
                          primary key (id_ipc));   

create table moneda_oficial (id_moneda int not null auto_increment,
							 moneda varchar (40),
                             primary key (id_moneda));

create table t_pbi_per_capita (id_pbi int not null auto_increment,
				      pbi_per_capita int,
                      primary key (id_pbi));

create table ranking (id_puntaje int not null auto_increment,
				      puntaje int,
                      margenes_de_error int,
                      puntaje_max int,
                      puntaje_min int,
                      aporte_pbi_per_capita int,
                      aporte_apoyo_social int,
                      aporte_exp_vida_buena_salud int,
                      aporte_libertad_en_decisiones int,
                      aporte_generosidad int,
                      aporte_percepcion_corrupcion int,
                      dystopia_sumado_a_valor_residual int,
                      primary key (id_puntaje));

create table poblacion (id_poblacion int not null auto_increment,
				      habitantes int,
                      habitantes_mujeres int,
                      habitantes_hombres int,
                      tasa_natalidad int,
                      tasa_fertilidad int,
                      esperanza_de_vida_m int,
                      esperanza_de_vida_h int,
                      exp_vida_buena_salud int,
                      primary key (id_poblacion));

create table trabajo (id_trabajo int not null auto_increment,
				          poblacion_trabajadora_redondeo int,
                          tasa_desempleo decimal (10,2),
                          primary key (id_trabajo)); 

create table regiones (id_region int not null auto_increment,
				          region varchar (60),
                          primary key (id_region)); 

create table sociedad (id_sociedad int not null auto_increment,
				      apoyo_social int,
                      libertad_en_decisiones int,
                      generosidad int,
                      percepcion_corrupcion int,
                      primary key (id_sociedad));

create table paises (id_pais int not null auto_increment,
					pais varchar (200),
					capital varchar (200),
                    sigla varchar (50),
                    id_continente int not null,
                    id_puntaje int not null,
                    id_idioma int not null,
                    id_gobierno int not null,
                    id_moneda int not null,
                    id_region int not null,
                    id_poblacion int not null,
                    id_educacion int not null,
                    id_trabajo int not null,
                    id_ipc int not null,
                    id_pbi int not null,
                    id_sociedad int not null,
                    primary key (id_pais),
					foreign key (id_continente) references continentes(id_continente), 
                    foreign key (id_puntaje) references ranking(id_puntaje), 
                    foreign key (id_idioma) references idiomas(id_idioma),
					foreign key (id_gobierno) references gobiernos(id_gobierno), 
                    foreign key (id_moneda) references moneda_oficial(id_moneda),
					foreign key (id_region) references regiones(id_region),
                    foreign key (id_poblacion) references poblacion(id_poblacion),
                    foreign key (id_educacion) references educacion(id_educacion),
                    foreign key (id_trabajo) references trabajo(id_trabajo),
                    foreign key (id_ipc) references t_ipc(id_ipc),
                    foreign key (id_pbi) references t_pbi_per_capita(id_pbi),
					foreign key (id_sociedad) references sociedad(id_sociedad));
                    

select * from paises;

alter table poblacion add column promedio_de_vida decimal (10, 1);



              





