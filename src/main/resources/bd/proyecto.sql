CREATE DATABASE proyecto
go
USE proyecto

CREATE TABLE tb_categoria(
idcat INT PRIMARY KEY,
nomcat VARCHAR(50),
)

CREATE TABLE tb_evento(
idevento INT PRIMARY KEY,
nomevento VARCHAR(50),
desevento VARCHAR(100),
idcat INT,
FOREIGN KEY(idcat) REFERENCES tb_categoria(idcat)
)

CREATE TABLE tb_funcion(
idfuncion INT PRIMARY KEY,
idevento INT,
precio DECIMAL(8,2),
unidades INT,
fecha DATE,
horainicio CHAR(5),
horafin CHAR(5),
FOREIGN KEY(idevento) REFERENCES tb_evento(idevento)
)

CREATE TABLE tb_usuario(
idusu INT PRIMARY KEY,
nomusu VARCHAR(100),
apeusu VARCHAR(100),
dni CHAR(8),
username CHAR(12),
clave CHAR(12),
fecRegistro DATETIME
)

CREATE TABLE tb_ticket
(
idticket VARCHAR(8) PRIMARY KEY,
dnicli CHAR(8),
nomcli VARCHAR(150),
emailcli VARCHAR(150),
telefono CHAR(9),
fecTicket DATE DEFAULT GETDATE()
)

CREATE TABLE tb_ticket_detalle
(
  iddetalle INT PRIMARY KEY IDENTITY,
  idticket VARCHAR(8),
  idfuncion INT,
  precio DECIMAL(8,2),
  unidades INT,
  FOREIGN KEY (idticket) REFERENCES tb_ticket(idticket),
  FOREIGN KEY (idfuncion) REFERENCES tb_funcion(idfuncion)
)

-- registros tb_categoria
insert into tb_categoria values(1,'Comedia')
insert into tb_categoria values(2,'Musica')
insert into tb_categoria values(3,'Teatro')

-- registros tb_evento
insert into tb_evento values(1,'LAS BANDALAS 2','espectáculo de humor mas exitos de los ultimos años',1)
insert into tb_evento values(2,'Chapa tu money','juegos y mas',3)
insert into tb_evento values(3,'Edicion limitada','musica en vivo',2)

-- registros tb_funcion
insert into tb_funcion values(1,1,100.00,80,'2023-11-28','19:00','21:00')
insert into tb_funcion values(2,1,100.00,80,'2023-11-28','19:00','21:00')
insert into tb_funcion values(3,2,120.00,80,'2023-11-29','19:00','22:00')
insert into tb_funcion values(4,2,120.00,80,'2023-11-29','19:00','22:00')
insert into tb_funcion values(5,3,90.00,80,'2023-11-30','19:00','21:00')
insert into tb_funcion values(6,3,90.00,80,'2023-11-30','19:00','21:00')

-- registros tb_usuario
insert into tb_usuario values(1,'Miguel','Ruiz','72686871','mars','mars',CURRENT_TIMESTAMP)


CREATE PROCEDURE usp_Evento_Listar
AS
BEGIN
	SELECT e.idevento, e.nomevento, e.desevento, c.nomcat
	FROM tb_evento e INNER JOIN tb_categoria c ON e.idcat = c.idcat
END
go

CREATE PROCEDURE usp_Funcion_Listar
AS
BEGIN
	SELECT f.idfuncion, e.nomevento, f.precio, f.unidades,
	f.fecha, f.horainicio, f.horafin
	FROM tb_funcion f INNER JOIN tb_evento e ON f.idevento = e.idevento
END
go

CREATE PROCEDURE usp_Categoria_Listar
AS
BEGIN
	SELECT idcat, nomcat
	FROM tb_categoria
END
go

CREATE PROCEDURE usp_Evento_GenerarId
AS
BEGIN
  SELECT idevento = ISNULL(MAX(idevento),0) + 1 FROM tb_evento
END
go

CREATE PROCEDURE usp_Evento_Eliminar
@idevento int
AS
BEGIN
	DELETE FROM tb_evento WHERE idevento = @idevento
END
go

CREATE PROCEDURE usp_merge_evento
@idevento int,
@nomevento varchar(50),
@desevento varchar(100),
@idcat int
AS
Merge tb_evento as target
using(Select @idevento,@nomevento,@desevento,@idcat) as source(id,nombre,des,idcat)
on target.idevento=source.id
When Matched then
  Update Set target.nomevento=source.nombre, target.desevento=source.des,
  target.idcat=source.idcat
When not Matched then
  Insert Values(source.id, source.nombre, source.des, source.idcat);
go

CREATE PROCEDURE usp_Funcion_GenerarId
AS
BEGIN
  SELECT idfuncion = ISNULL(MAX(idfuncion),0) + 1 FROM tb_funcion
END
go


CREATE PROCEDURE usp_Funcion_Eliminar
@idfuncion int
AS
BEGIN
	DELETE FROM tb_funcion WHERE idfuncion = @idfuncion
END
go


CREATE PROCEDURE usp_merge_funcion
@idfuncion int,
@idevento int,
@precio decimal(8,2),
@unidades int,
@fecha date,
@horainicio char(5),
@horafin char(5)
AS
Merge tb_funcion as target
using(Select @idfuncion,@idevento,@precio,@unidades,@fecha,@horainicio,@horafin) as source(id,even,pre,uni,fec,hini,hfin)
on target.idfuncion=source.id
When Matched then
  Update Set target.idevento=source.even, target.precio=source.pre, target.unidades=source.uni,
  target.fecha = source.fec, target.horainicio = source.hini, target.horafin = source.hfin
When not Matched then
  Insert Values(source.id, source.even, source.pre, source.uni, source.fec, source.hini, source.hfin);
go


CREATE PROCEDURE usp_cboEvento_Listar
AS
BEGIN
	SELECT idevento, nomevento
	FROM tb_evento
END
go


CREATE PROCEDURE usp_login
(
   @usuario CHAR(12),
   @contrasena CHAR(12)
)
AS
BEGIN
   SELECT username, clave
   FROM tb_usuario
   WHERE username = @usuario AND clave = @contrasena
END
go


CREATE FUNCTION fc_autogenera() returns varchar(8)
AS
BEGIN
   DECLARE @n INT
   DECLARE @aux varchar(8) = (select top 1 idticket from tb_ticket order by 1 desc)
if(@aux is null)
   set @n = 1
else
   set @n = CAST(@aux AS INT) + 1
RETURN REPLICATE('0',8-LEN(CAST(@n AS NVARCHAR(8)))) + CAST(@n as VARCHAR(8))
END
go


CREATE PROCEDURE usp_ticket_add
(
	@idticket varchar(8) output,
	@dnicli char(8),
	@nomcli varchar(150),
	@emailcli varchar(150),
	@telefono char(9)
)
AS
BEGIN
   SET @idticket = dbo.fc_autogenera()
   INSERT INTO tb_ticket(idticket,dnicli,nomcli,emailcli,telefono)
   VALUES(@idticket,@dnicli,@nomcli,@emailcli,@telefono)
END
go


CREATE PROCEDURE usp_ticket_detalle_add
(
   @idticket varchar(8),
   @idfuncion int,
   @precio decimal(8,2),
   @cantidad int
)
AS
BEGIN
   INSERT tb_ticket_detalle
   VALUES(@idticket,@idfuncion,@precio,@cantidad)
END
go


CREATE PROCEDURE usp_Usuario_Listar
AS
BEGIN
	SELECT u.idusu, u.nomusu, u.apeusu, u.dni, u.username, u.clave, u.fecRegistro
	FROM tb_usuario u
END
go


CREATE PROCEDURE usp_Usuario_GenerarId
AS
BEGIN
  SELECT idusu = ISNULL(MAX(idusu),0) + 1 FROM tb_usuario
END
go


CREATE PROCEDURE usp_Usuario_Eliminar
@idusu int
AS
BEGIN
	DELETE FROM tb_usuario WHERE idusu = @idusu
END
go


CREATE PROCEDURE usp_merge_usuario
@idusu int,
@nomusu varchar(100),
@apeusu varchar(100),
@dni char(8),
@username char(12),
@clave char(12)
AS
Merge tb_usuario as target
using(Select @idusu,@nomusu,@apeusu,@dni,@username,@clave,GETDATE()) as source(idusu,nom,ape,dni,username,clave,fec)
on target.idusu=source.idusu
When Matched then
  Update Set target.nomusu=source.nom, target.apeusu=source.ape, target.dni=source.dni,
  target.username=source.username, target.clave=source.clave, target.fecRegistro=source.fec
When not Matched then
  Insert Values(source.idusu, source.nom, source.ape, source.dni, source.username, source.clave, source.fec);
go


SELECT * FROM tb_ticket
SELECT * FROM tb_ticket_detalle
