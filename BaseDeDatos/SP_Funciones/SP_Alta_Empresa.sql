CREATE PROCEDURE LOOPP.SP_NuevoEmpresa
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
   ,@user varchar(255)
   ,@pass varchar(255)
   ,@fec_creacion datetime
   ,@resultado varchar(255) output
AS
	BEGIN TRANSACTION [T]

	BEGIN TRY
		/*En el momento de crear usuarios, el campo username tiene una constraint de unicidad, si ya existe uno igual dara error de constraint*/
		insert into [LOOPP].[Usuarios](
					[username]
					,[password])
		values (@user,@pass);
		
		declare @idUsu int;
		select @idUsu=[id_usuario]
		from [LOOPP].[Usuarios]
		where [username]=@user;

		INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
		VALUES (@idUsu,3);

		if not exists (select 1 from [LOOPP].[Empresas] where cuit=@cuit and [mail]=@email and [razon_social]=@razon)
		begin
			insert into [LOOPP].[Empresas](
					   [razon_social]
					  ,[cuit]
					  ,[fecha_creacion]
					  ,[mail]
					  ,[telefono]
					  ,[direccion_calle]
					  ,[direccion_nro]
					  ,[direccion_piso]
					  ,[direccion_depto]
					  ,[direccion_localidad]
					  ,[cod_postal]
					  ,[ciudad]
					  ,[id_usuario] )
			values (@razon,@cuit,@fec_creacion,@email,@tel,@dir,@dir_nro,@dir_piso,@dir_depto,@localidad,@codPostal,@ciudad,@idUsu)
		end
		else set @resultado = 'La empresa ya existe en el sistema'
	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
GO