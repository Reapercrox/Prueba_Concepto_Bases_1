USE TareaProgramada1
GO
CREATE PROC SP_VNombre(
@Nombre varchar(128)
)
AS
BEGIN
SELECT * FROM [dbo].[Articulo] WHERE Nombre = @Nombre
END

--EXEC SP_VNombre 'clavos'
