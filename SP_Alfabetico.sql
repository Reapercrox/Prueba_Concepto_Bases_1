
USE TareaProgramada1;
GO
CREATE PROCEDURE SP_Alfabetico

AS
BEGIN
SELECT * FROM Articulo 
ORDER BY Nombre
END

--exec SP_Alfabetico

