USE [GD2C2018]
GO

CREATE PROCEDURE [LOOPP].[SP_ModificarPublicacion]
	@descripcion nvarchar(255),
	@direccion nvarchar(255)
   ,@id_grado_publicacion int
   ,@id_estado int
   ,@rubro int
   ,@precio_base numeric(18,0)
   ,@fechaEspec date
   ,@horaEspec varchar(255)
   ,@id_espectaculo int
  AS
	declare @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		IF EXISTS (
			SELECT 1 
			FROM LOOPP.Espectaculos  
			WHERE descripcion=@descripcion and direccion=@direccion and id_espectaculo= @id_espectaculo and hora_espectaculo= CONVERT(time,@horaEspec) and fecha_espectaculo = @fechaEspec)
		BEGIN
			RAISERROR('Existe un mismo espectaculo con la misma fecha y hora. Ingrese otro horario y/o fecha ',16,1)
		END

		UPDATE LOOPP.Espectaculos
		SET 
			descripcion=@descripcion,
			direccion=@direccion,
			id_grado_publicacion=@id_grado_publicacion,
			id_estado_publicacion=@id_estado,
			id_rubro=@rubro,
			precio_base=@precio_base,
			fecha_espectaculo=@fechaEspec,
			hora_espectaculo=@horaEspec
		WHERE id_espectaculo=@id_espectaculo

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
