IF OBJECT_ID('LOOPP.SP_ModificarEmpresa') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ModificarEmpresa
GO

CREATE PROCEDURE [LOOPP].[SP_ModificarEmpresa]
	@idEmpresa int,
	@razon varchar(255)
   ,@cuit varchar(255)
   ,@email varchar(50)
   ,@tel varchar(15)
   ,@dir varchar(50)
   ,@dir_nro numeric(18,0)
   ,@dir_piso numeric(18,0)
   ,@dir_depto varchar(50)
   ,@localidad varchar(50)
   ,@ciudad varchar(50)
   ,@codPostal varchar(50)
   ,@bajaLogica bit
  AS
	declare @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		IF EXISTS (SELECT 1 FROM LOOPP.Empresas  WHERE cuit = @cuit and id_empresa != @idEmpresa)
		BEGIN
			RAISERROR('Ya se encuentra registrado una empresa con el mismo CUIT',16,1)
		END
		ELSE IF EXISTS (SELECT 1 FROM LOOPP.Empresas  WHERE mail = @email and id_empresa != @idEmpresa)
		BEGIN
			RAISERROR('Ya se encuentra registrado una empresa con el mismo email',16,1)
		END

		UPDATE LOOPP.Empresas
		SET 
			razon_social=@razon,
			cuit=@cuit,
			mail=@email,
			telefono=@tel,
			direccion_calle=@dir,
			direccion_nro=@dir_nro,
			direccion_piso=@dir_piso,
			direccion_depto=@dir_depto,
			direccion_localidad=@localidad,
			ciudad=@ciudad,
			cod_postal=@codPostal,
			baja_logica=@bajaLogica
		WHERE id_empresa=@idEmpresa

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado