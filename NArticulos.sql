USE TareaProgramada1;
GO
CREATE PROC SP_NArticulos(
	@N int
)
AS
BEGIN
SELECT TOP (@N) * FROM Articulo 
END

--EXEC SP_NArticulos 50