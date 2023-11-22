-- borra la bd si existe
DROP DATABASE IF EXISTS bd_teatro;
-- creamos la bd
CREATE DATABASE bd_teatro;
-- activamos la bd
USE bd_teatro;

CREATE TABLE tb_categoria(
idcat INT auto_increment,
nomcat VARCHAR(100),
descat VARCHAR(100),
PRIMARY KEY(idcat)
);

CREATE TABLE tb_evento(
idevento INT auto_increment,
nomevento VARCHAR(100),
desevento VARCHAR(100),
idcat INT,
PRIMARY KEY(idevento),
FOREIGN KEY(idcat) REFERENCES tb_categoria(idcat)
);

CREATE TABLE tb_funcion(
idfuncion INT auto_increment,
idevento INT,
fecha DATE,
horainicio VARCHAR(6),
horafin VARCHAR(6),
PRIMARY KEY(idfuncion),
FOREIGN KEY(idevento) REFERENCES tb_evento(idevento)
);

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

CREATE TABLE tb_cliente(
idcli INT auto_increment,
nomcli VARCHAR(50),
apecli VARCHAR(50),
dni CHAR(8),
username VARCHAR(30),
clave VARCHAR(30),
idTipo int,
PRIMARY KEY(idcli),
FOREIGN KEY(idTipo) REFERENCES tb_tipo(idTipo)
);

insert into tb_cliente values(null,'Miguel','Ruiz','87654321','admin@mail.com','admin',1);



-- en la tabla area de almacena la cantidad de asientos y la tabla ticket
--  descuenta con las unidades compradas
CREATE TABLE tb_ticket(
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
);

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