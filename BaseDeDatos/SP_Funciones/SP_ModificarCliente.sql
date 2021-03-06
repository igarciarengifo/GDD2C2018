IF OBJECT_ID('LOOPP.SP_ModificarCliente') IS NOT NULL
DROP PROCEDURE LOOPP.SP_ModificarCliente
GO

CREATE PROCEDURE [LOOPP].[SP_ModificarCliente]
	@nombre varchar(255)
   ,@apellido varchar(255)
   ,@tipo_doc varchar(20)
   ,@documento numeric(18,0)
   ,@cuil varchar(15)
   ,@fecha_nac datetime
   ,@mail varchar(255)
   ,@telefono varchar(15)
   ,@calle varchar(255)
   ,@nroCalle numeric(18,0)
   ,@piso numeric(18,0)
   ,@depto varchar(255)
   ,@localidad varchar(255)
   ,@cod_postal varchar(255)
   ,@baja_logica bit
   ,@idCliente int
  
  AS
	declare @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		IF EXISTS (SELECT 1 FROM LOOPP.Clientes  WHERE cuil = @cuil and id_cliente != @idCliente)
		BEGIN
			RAISERROR('Ya se encuentra registrado un cliente con el mismo CUIL',16,1)
		END
		ELSE IF EXISTS (SELECT 1 FROM LOOPP.Clientes  WHERE mail = @mail and id_cliente != @idCliente)
		BEGIN
			RAISERROR('Ya se encuentra registrado un cliente con el mismo email',16,1)
		END

		UPDATE LOOPP.Clientes
		SET
			nombre=@nombre,
			apellido=@apellido,
			tipo_documento=@tipo_doc,
			nro_documento=@documento,
			fecha_nacimiento=@fecha_nac,
			cuil=@cuil,
			mail=@mail,
			telefono=@telefono,
			direccion_calle=@calle,
			direccion_nro=@nroCalle,
			direccion_piso=@piso,
			direccion_depto=@depto,
			direccion_localidad=@localidad,
			
			codigo_postal=@cod_postal,
			baja_logica=@baja_logica

		WHERE id_cliente=@idCliente

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado