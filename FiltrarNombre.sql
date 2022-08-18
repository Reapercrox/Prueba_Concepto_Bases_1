USE TareaProgramada1;
GO
CREATE PROC SP_FiltrarNombre(
	@Palabra varchar(128)
)
AS
BEGINSELECT * FROM Articulo WHERE Nombre LIKE '%'+@Palabra+'%'
end

--EXEC SP_FiltrarNombre '5'