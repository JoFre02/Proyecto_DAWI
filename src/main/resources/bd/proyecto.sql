-- borra la bd si existe
DROP DATABASE IF EXISTS bd_teatro;
-- creamos la bd
CREATE DATABASE bd_teatro;
-- activamos la bd
USE bd_teatro;

CREATE TABLE tb_categoria(
idcat INT,
nomcat VARCHAR(100),
PRIMARY KEY(idcat)
);

CREATE TABLE tb_evento(
idevento INT,
nomevento VARCHAR(100),
desevento VARCHAR(100),
idcat INT,
PRIMARY KEY(idevento),
FOREIGN KEY(idcat) REFERENCES tb_categoria(idcat)
);

CREATE TABLE tb_funcion(
idfuncion INT ,
idevento INT,
fecha DATE,
horainicio VARCHAR(6),
horafin VARCHAR(6),
PRIMARY KEY(idfuncion),
FOREIGN KEY(idevento) REFERENCES tb_evento(idevento)
);

CREATE TABLE tb_cliente(
idcli INT auto_increment not null,
nomcli VARCHAR(50) not null,
apecli VARCHAR(50) not null,
dni CHAR(8) not null,
username VARCHAR(30) unique not null,
clave VARCHAR(30) not null,
PRIMARY KEY(idcli)
);

-- en la tabla area de almacena la cantidad de asientos y la tabla ticket
--  descuenta con las unidades compradas
/*CREATE TABLE tb_ticket(
idTicket INT auto_increment,
idfuncion INT,
id_area int,
idcli int,
unidades INT,
total double,
PRIMARY KEY(idTicket),
FOREIGN KEY (idfuncion) REFERENCES tb_funcion(idfuncion),
FOREIGN KEY (id_area) REFERENCES tb_area(id_area),
FOREIGN KEY (idcli) REFERENCES tb_cliente(idcli)
);*/

/*
CREATE TABLE tb_area(
id_area INT auto_increment,
idfuncion int,
nom_area VARCHAR(30),
precio dec,
asientos int,
PRIMARY KEY(id_area),
FOREIGN KEY(idfuncion) REFERENCES tb_funcion(idfuncion)
);

CREATE TABLE tb_tipo(
idTipo int primary key,
descripcion varchar (20)
);
insert into tb_tipo values(1, 'administrador');
insert into tb_tipo values(2, 'cliente');
*/

/*
CREATE TABLE tb_detalleTicket(
idDetalleTicket INT auto_increment,
idTicket int,
idcli INT,
PRIMARY KEY(idticket),
FOREIGN KEY (idcli) REFERENCES tb_cliente(idcli)
);

CREATE TABLE tb_asiento(
id_asiento INT auto_increment,
id_area INT,
cantidad INT,
PRIMARY KEY(id_asiento),
FOREIGN KEY(id_area) REFERENCES Area(id_area)
);
*/
-- registro tb_cliente
insert into tb_cliente values(null,'Brayan','Pichiule','87654321','admin@mail.com','admin');
insert into tb_cliente values(null,'Miguel','Ruiz','87654321','miguelr@mail.com','miguelr');

-- registro tb_categoria
insert into tb_categoria values(1,'Comedia');
insert into tb_categoria values(2,'Romance');
insert into tb_categoria values(3,'Drama');
insert into tb_categoria values(4,'Música');

-- registro tb_evento
insert into tb_evento values(1,'BROMATES','Mejores amigos se mudan juntos',1);
insert into tb_evento values(2,'ROMEO Y JULIETA','Basado en el libro de William Shakespeare',2);
insert into tb_evento values(3,'HAMLET','Basado en el libro de William Shakespeare',3);
insert into tb_evento values(4,'EDICIÓN LIMITADA','Musicos que no conocias',4);
insert into tb_evento values(5,'COMEDY FEST',' Grandes comediantes se juntaron',1);
insert into tb_evento values(6,'LOS AMANTES DE TERUEL','Leyenda de los amantes de Teruel',2);
insert into tb_evento values(7,'LA DIVINA COMEDIA','Basado en poema de Dante Alighieri',3);
insert into tb_evento values(8,'GIAN MARCO','Concierto inolvidable con Gian Marco',4);

-- registro tb_funcion
insert into tb_funcion values(1,1,'2023-12-08','19:00','21:00');
insert into tb_funcion values(2,2,'2023-12-06','18:00','20:00');
insert into tb_funcion values(3,3,'2023-12-07','18:00','20:00');
insert into tb_funcion values(4,4,'2023-12-04','19:00','22:00');
insert into tb_funcion values(5,5,'2023-12-09','19:00','22:00');
insert into tb_funcion values(6,6,'2023-12-06','20:00','22:00');
insert into tb_funcion values(7,7,'2023-12-07','20:00','22:00');
insert into tb_funcion values(8,8,'2023-12-05','19:00','21:00');
insert into tb_funcion values(9,1,'2023-12-15','19:00','21:00');
insert into tb_funcion values(10,2,'2023-12-13','18:00','20:00');
insert into tb_funcion values(11,3,'2023-12-14','18:00','20:00');
insert into tb_funcion values(12,4,'2023-12-11','19:00','22:00');
insert into tb_funcion values(13,5,'2023-12-16','19:00','22:00');
insert into tb_funcion values(14,6,'2023-12-13','20:00','22:00');
insert into tb_funcion values(15,7,'2023-12-14','20:00','22:00');
insert into tb_funcion values(16,8,'2023-12-12','19:00','21:00');

select * from tb_funcion;


SELECT f.idfuncion, e.nomevento, f.fecha, f.horainicio, f.horafin
FROM tb_evento e INNER JOIN
tb_funcion f ON e.idevento = f.idevento



