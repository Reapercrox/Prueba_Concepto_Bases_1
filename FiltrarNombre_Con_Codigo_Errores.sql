USE TareaProgramada1;
GO
CREATE PROC SP_FiltrarNombre(
	@Palabra varchar(128)
)
AS

BEGIN

	SET NOCOUNT ON

	BEGIN TRY

		SELECT * FROM [dbo].[Articulo] WHERE Nombre LIKE '%'+@Palabra+'%'

	END TRY

	 	BEGIN CATCH

		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION tUpdateArticulo; -- se deshacen los cambios realizados
		END;
		INSERT INTO [dbo].[DBErrors]	VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
		);

		Set @outResultCode=50005;

	
	END CATCH

	SET NOCOUNT OFF

END

--EXEC SP_FiltrarNombre '5'