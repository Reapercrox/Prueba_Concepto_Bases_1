USE TareaProgramada1;
GO

CREATE PROCEDURE SP_Login
	@Usuario varchar(16),
	@Password varchar(16)


AS

BEGIN

	SET NOCOUNT ON
	
	BEGIN TRY

		SELECT * FROM [dbo].[Usuario] WHERE UserName = @Usuario AND Password = @Password

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