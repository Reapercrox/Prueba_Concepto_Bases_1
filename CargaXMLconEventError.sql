CREATE DATABASE TareaProgramada1;
USE TareaProgramada1;
GO

CREATE TABLE [dbo].[Usuario] ( 
id INT IDENTITY (1, 1) PRIMARY KEY, 
UserName VARCHAR(16), 
Password VARCHAR (16) 
) 

CREATE TABLE [dbo].[ClaseArticulo] (
id INT IDENTITY (1,1) PRIMARY KEY,
Nombre_clase VARCHAR(128)
)

CREATE TABLE [dbo].[Articulo] ( 
id INT IDENTITY (1, 1) PRIMARY KEY, 
Nombre VARCHAR(128), 
Precio MONEY,
id_clase INT IDENTITY (1,1) FOREIGN KEY REFERENCES [dbo].[ClaseArticulo](id)
) 

CREATE TABLE [dbo].[EventLog](
id INT IDENTITY (1,1) PRIMARY KEY,
LogDescription VARCHAR (128),
PostDateTime DATETIME,
PostUserId INT IDENTITY (1,1) FOREIGN KEY REFERENCES [dbo].[Usuario](id),
PostInIp VARCHAR(64)
)

CREATE TABLE [dbo].[DBErrors](
[ErrorID] [int] IDENTITY (1,1) NOT NULL,
[UserName] [varchar] (100) NULL,
[ErrorNumber] [int] NULL,
[ErrorState] [int] NULL,
[ErrorSeverity] [int] NULL,
[ErrorLine] [int] NULL,
[ErrorProcedure] [varchar] (max) NULL,
[ErrorMessage] [varchar] (max) NULL,
[ErrorDateTime] [datetime] NULL,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


delete [dbo].[Usuario]
delete [dbo].[ClaseArticulo]
delete [dbo].[Articulo]


CREATE TABLE [dbo].[ClaseTemp] (
id INT IDENTITY (1,1) PRIMARY KEY,
Nombre_clase VARCHAR(128)
)

INSERT INTO [dbo].[Usuario]

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

SELECT * FROM [dbo].[Usuario]

INSERT INTO [dbo].[ClaseArticulo]

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

SELECT * FROM [dbo].[ClaseArticulo]

INSERT INTO [dbo].[ClaseTemp]

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

SELECT * FROM [dbo].[ClaseTemp]

INSERT INTO [dbo].[Articulo]

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

SELECT * FROM [dbo].[Articulo]


INSERT INTO [dbo].[Articulo]

Select  
	CA.id as id_clase
from (
	[dbo].[ClaseTemp] as A cross join
	[dbo].[ClaseArticulo] as CA
	)
where
	A.Nombre_clase = CA.Nombre_clase


SELECT * FROM Articulo

delete [dbo].[ClaseTemp]