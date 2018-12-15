IF OBJECT_ID('LOOPP.SP_NuevoCliente') IS NOT NULL
DROP PROCEDURE LOOPP.SP_NuevoCliente
GO

CREATE PROCEDURE LOOPP.SP_NuevoCliente 
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
   ,@user varchar(255)
   ,@pass varchar(255)
   
AS
	declare @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		declare @idUsu int;
		/*En el momento de crear usuarios, el campo username tiene una constraint de unicidad, si ya existe uno igual dara error de constraint*/
		if ( @user is null)
			begin
				EXEC @idUsu =  LOOPP.SP_AltaUsuario_Autogenerado @cuil, @nombre
				SET @resultado = CONVERT(varchar(255), @idUsu)+';'+@cuil + '!' + @nombre
			end
		else
			begin
				insert into [LOOPP].[Usuarios](
							[username]
							,[password])
				values (@user,@pass);
		

				select @idUsu=[id_usuario]
				from [LOOPP].[Usuarios]
				where [username]=@user;
		end
		INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
		VALUES (@idUsu,2);

		if not exists (select 1 from [LOOPP].[Clientes] where tipo_documento=@tipo_doc and nro_documento=@documento and mail=@mail)
		begin
			insert into [LOOPP].[Clientes] (
					   [nombre]
					  ,[apellido]
					  ,[tipo_documento]
					  ,[nro_documento]
					  ,[cuil]
					  ,[fecha_nacimiento]
					  ,[mail]
					  ,[telefono]
					  ,[direccion_calle]
					  ,[direccion_nro]
					  ,[direccion_piso]
					  ,[direccion_depto]
					  ,[direccion_localidad]
					  ,[codigo_postal]
					  ,[id_usuario] )
			values (@nombre,@apellido,@tipo_doc,@documento,@cuil,@fecha_nac,@mail,@telefono,@calle,@nroCalle,@piso,@depto,@localidad,@cod_postal,@idUsu)
			SET @resultado = '-'
		end
		else set @resultado = 'El cliente ya existe en el sistema'
	
	COMMIT TRANSACTION [T]

	set @resultado = @resultado +';OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	select @resultado
GO