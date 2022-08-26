USE TareaProgramada1
GO
CREATE PROC SP_INS_Articulo(

	@Nombre varchar(128),
	@Precio money,
	@id_clase INT,
	@Nombre_Clase varchar(128),
	@OutResultCode int OUTPUT

)
AS-- as quiere decir que le va a dar comienzo al script del procedimiento
--Contenido
BEGIN
	
	SET NOCOUNT ON

	BEGIN TRY

		INSERT INTO [dbo].[Articulo] VALUES(@Nombre,@Precio)
		SELECT * FROM [dbo].[Articulo]

		INSERT INTO [dbo].[Articulo] VALUES(@id_clase)
		SELECT @id FROM [dbo].[CLASE_ARTICULO] as A
		WHERE A.Nombre_Clase = @Nombre_Clase

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