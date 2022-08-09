USE TareaProgramada1
GO
CREATE PROC SP_INS_Articulo(
@Nombre varchar(128),
@Precio money
)
AS-- as quiere decir que le va a dar comienzo al script del procedimiento
--Contenido
BEGIN
 INSERT INTO Articulo VALUES(@Nombre,@Precio)
 SELECT * FROM Articulo
 END