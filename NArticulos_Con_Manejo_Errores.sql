USE TareaProgramada1;
GO
CREATE PROC SP_NArticulos(
	@N int
)


AS
BEGIN
		
	SET NOCOUNT ON

	BEGIN TRY

		SELECT TOP (@N) * FROM [dbo].[Articulo] 

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

--EXEC SP_NArticulos 50