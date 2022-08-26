CREATE DATABASE TareaProgramada1;
USE TareaProgramada1;
GO

CREATE TABLE Usuario ( 
id INT IDENTITY (1, 1) PRIMARY KEY, 
UserName VARCHAR(16), 
Password VARCHAR (16) 
) 

CREATE TABLE CLASE_ARTICULO (
id INT IDENTITY (1,1) PRIMARY KEY,
Nombre_clase VARCHAR(128)
)

CREATE TABLE Articulo ( 
id INT IDENTITY (1, 1) PRIMARY KEY, 
Nombre VARCHAR(128), 
Precio MONEY,
id_clase INT IDENTITY (1,1) FOREIGN KEY REFERENCES CLASE_ARTICULO(id)
) 

delete dbo.Usuario
delete dbo.CLASE_ARTICULO
delete dbo.Articulo


CREATE TABLE CLASE_TEMP (
id INT IDENTITY (1,1) PRIMARY KEY,
Nombre_clase VARCHAR(128)
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

INSERT INTO CLASE_ARTICULO

Select  
	A.ClasesDeArticulos.value('@Nombre','varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\datos.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Datos/ClasesDeArticulos/ClasesDeArticulos') as A(ClasesDeArticulos)

SELECT * FROM CLASE_ARTICULO

INSERT INTO CLASE_TEMP

Select  
	A.ClasesDeArticulos.value('@Nombre','varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\datos.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Datos/ClasesDeArticulos/ClasesDeArticulos') as A(ClasesDeArticulos)

SELECT * FROM CLASE_TEMP

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


INSERT INTO Articulo

Select  
	CA.id as id_clase
from (
	dbo.CLASE_TEMP as A cross join
	dbo.CLASE_ARTICULO as CA
	)
where
	A.Nombre_clase = CA.Nombre_clase


SELECT * FROM Articulo

delete dbo.CLASE_TEMP