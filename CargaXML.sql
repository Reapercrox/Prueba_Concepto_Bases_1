CREATE DATABASE TareaProgramada1;
USE TareaProgramada1;
GO

CREATE TABLE Usuario ( 
id INT IDENTITY (1, 1) PRIMARY KEY, 
UserName VARCHAR(16), 
Password VARCHAR (16) 
) 
CREATE TABLE Articulo ( 
id INT IDENTITY (1, 1) PRIMARY KEY, 
Nombre VARCHAR(128), 
Precio MONEY 
 ) 


INSERT INTO Usuario

Select  
	A.Usuarios.value('@Nombre','varchar(16)') as Usuario,
	A.Usuarios.value('@Password','varchar(16)') as Password
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\isaac\Desktop\XML\Data.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Datos/Usuarios/Usuario') as A(Usuarios)

SELECT * FROM Usuario

INSERT INTO Articulo

Select  
	A.Articulos.value('@Nombre','varchar(128)') as Nombre,
	A.Articulos.value('@Precio','Money') as Precio
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\isaac\Desktop\XML\Data.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Datos/Articulos/Articulo') as A(Articulos)

SELECT * FROM Articulo