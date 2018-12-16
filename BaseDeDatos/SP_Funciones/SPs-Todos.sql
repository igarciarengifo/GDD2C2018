/*##########################################################################################################*/
/*										CREACION DE SPs y FN												*/
/*##########################################################################################################*/

/* LOOPP.SP_NuevoCliente */

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

---------------------------------------------------------------------------------------

/* LOOPP.SP_FiltrarClientes */

IF OBJECT_ID('LOOPP.SP_FiltrarClientes') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_FiltrarClientes];
GO

CREATE PROCEDURE [LOOPP].[SP_FiltrarClientes]
	@nombre nvarchar(255),
	@apellido nvarchar(255),
	@email nvarchar(255),
	@nroDoc numeric(18,0)

AS
BEGIN
	SELECT C.id_cliente, C.apellido, C.nombre, C.mail, C.tipo_documento, C.nro_documento, C.fecha_nacimiento, C.direccion_calle, C.direccion_nro, C.direccion_localidad, C.estado, C.baja_logica
	FROM [LOOPP].Clientes as C
	WHERE (C.nombre=@nombre OR @nombre IS NULL OR @nombre = '')
	AND (C.apellido = @apellido OR @apellido IS NULL OR @apellido = '')
	AND (C.mail = @email OR @email IS NULL OR @email = '')
	AND (C.nro_documento = @nroDoc OR @nroDoc IS NULL OR @nroDoc=0)
END
GO

-------------------------------------------------------------------------
/* LOOPP.SP_GetClientePorId */

IF OBJECT_ID('LOOPP.SP_GetClientePorId') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetClientePorId];
GO
CREATE PROCEDURE [LOOPP].[SP_GetClientePorId]
	
	@idCliente int
AS
BEGIN
	SELECT * FROM Clientes WHERE id_cliente=@idCliente
END
GO

--------------------------------------------------------------------------
/* LOOPP.SP_ModificarCliente */

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
GO

-----------------------------------------------------------------------
/* LOOPP.SP_UserHasInvalidInfo */

IF OBJECT_ID('LOOPP.SP_UserHasInvalidInfo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_UserHasInvalidInfo
GO

create procedure LOOPP.SP_UserHasInvalidInfo (@id_user int)
as
begin

	declare @result bit
	select @result=case when estado='Inconsistente' then 1 else 0 end
	from LOOPP.Clientes	
	where id_usuario=@id_user
	if @result is null 
	begin
		set @result=0
	end
	select @result
end
GO

-----------------------------------------------------------------------
/*Funcion que calcula precio de entrada segun ubicacion*/

IF OBJECT_ID('LOOPP.Fn_PrecioXUbicacion') IS NOT NULL
    DROP FUNCTION LOOPP.Fn_PrecioXUbicacion
GO

create function LOOPP.Fn_PrecioXUbicacion (@gradoPub int, @tipoUbicacion int,@precioBase numeric(18,2))
RETURNS numeric(18,2)
AS 
	BEGIN
		declare @precioEntrada numeric(18,2);
		declare @porcXUbic numeric (10,2);
		declare @comision numeric (10,2);

		select @porcXUbic = [porcentual]
		from [LOOPP].[Ubicaciones] u
		inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
		where tu.id_tipo_ubicacion=@tipoUbicacion;

		select @comision=comision
		from [LOOPP].[Grados_Publicacion]
		where id_grado_publicacion=@gradoPub;

		set @precioEntrada = @precioBase + (@precioBase*@porcXUbic) + (@precioBase*@comision);
	
		RETURN @precioEntrada
	END
GO

IF OBJECT_ID('LOOPP.SP_NuevaPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevaPublicacion
GO

/*Inserta espectaculo nuevo y ubicacion por espectaculo con el precio segun ubicacion*/

create procedure LOOPP.SP_NuevaPublicacion @descripcion nvarchar(255)
										  ,@direccion nvarchar(50)
										  ,@id_grado_publicacion int
										  ,@id_estado int
										  ,@rubro int
										  ,@id_usuario int
										  ,@fecha_publicacion datetime
										  ,@precio_base numeric(18,2)
										  ,@fechaEspec date
										  ,@horaEspec time
										  ,@fechaVenc date
AS
	declare @resultado int;
	declare @newId int;

	select @newId=MAX([id_espectaculo])+1
	from [LOOPP].[Espectaculos];

	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.id_espectaculo=ue.id_espectaculo
				   where e.descripcion=@descripcion 
				   and e.fecha_publicacion=@fecha_publicacion
				   and ue.fecha_espectaculo=@fechaEspec
				   and ue.hora_espectaculo=@horaEspec
				   and id_estado_publicacion in (1,2,3))
	begin
		insert into [LOOPP].[Espectaculos]([id_espectaculo]
											,[id_usuario_responsable]
											,[id_rubro]
											,[fecha_publicacion]
											,[descripcion]
											,[direccion]
											,[id_estado_publicacion]
											,[id_grado_publicacion]
											,[precio_base])
		values (@newId,@id_usuario,@rubro,@fecha_publicacion,@descripcion,@direccion,@id_estado,@id_grado_publicacion,@precio_base)

		insert into [LOOPP].[Ubicac_X_Espectaculo] ([id_espectaculo]
													,[id_ubicacion]
													,[precio]
													,[fecha_espectaculo]
													,[fecha_venc_espectaculo]
													,[hora_espectaculo]
													)
		select @newId
			  ,id_ubicacion
			  ,LOOPP.Fn_PrecioXUbicacion(@id_grado_publicacion,id_tipo_ubicacion,@precio_base) precio
			  ,@fechaEspec
			  ,@fechaVenc
			  ,@horaEspec
		from [LOOPP].[Ubicaciones];
		
		select @resultado=MAX([id_espectaculo])
		from [LOOPP].[Espectaculos]

	end
	else set @resultado = -1;

	select @resultado;

GO

----------------------------------------------------------------------------------

/*LOOPP.SP_NuevoEmpresa */

IF OBJECT_ID('LOOPP.SP_NuevoEmpresa') IS NOT NULL
DROP PROCEDURE LOOPP.SP_NuevoEmpresa
GO

CREATE PROCEDURE [LOOPP].[SP_NuevoEmpresa]
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
AS
declare @resultado varchar(255)
BEGIN TRANSACTION [T]

BEGIN TRY
	/*En el momento de crear usuarios, el campo username tiene una constraint de unicidad, si ya existe uno igual dara error de constraint*/
	declare @idUsu int;
	if ( @user is null)
		begin
			EXEC @idUsu =  LOOPP.SP_AltaUsuario_Autogenerado @cuit, @razon
			SET @resultado = CONVERT(varchar(255), @idUsu)+';'+@cuit + '!' + @razon
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

set @resultado = @resultado +';OK';

END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION [T]

	set @resultado = ERROR_MESSAGE();

END CATCH;
SELECT @resultado
GO
----------------------------------------------------------------------------
/* LOOPP.SP_EsPrimerLogueo */

IF OBJECT_ID('LOOPP.SP_EsPrimerLogueo') IS NOT NULL
DROP PROCEDURE LOOPP.SP_EsPrimerLogueo
GO

CREATE PROCEDURE LOOPP.SP_EsPrimerLogueo (@id_user int)
as
begin
DECLARE @cuitCuil nvarchar(15), @nombre nvarchar(255), @pass varchar(255), @result bit
	SELECT @pass=password
	FROM LOOPP.Usuarios
	WHERE id_usuario=@id_user

	SELECT @cuitCuil=cuil, @nombre=nombre
	FROM LOOPP.Clientes
	WHERE id_usuario=@id_user

	SELECT @cuitCuil=cuit, @nombre=razon_social
	FROM LOOPP.Empresas
	WHERE id_usuario=@id_user
	
	if ( (@cuitCuil + '!' + @nombre) = @pass)
	
		set @result='true'
	
	else
		set @result='false'
	select @result
End
GO
---------------------------------------------------------------
/* LOOPP.SP_GetEmpresaPorId */

IF OBJECT_ID('LOOPP.SP_GetEmpresaPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEmpresaPorId
GO
CREATE PROCEDURE [LOOPP].[SP_GetEmpresaPorId]
	
	@idEmpresa int
AS
BEGIN
	SELECT * FROM Empresas WHERE id_empresa=@idEmpresa
END
GO
----------------------------------------------------------------
/*LOOPP.SP_InhabilitarRol*/

IF OBJECT_ID('LOOPP.SP_InhabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarRol
GO

CREATE PROCEDURE [LOOPP].[SP_InhabilitarRol] @idRol int
AS
	declare @resultado varchar(10);
	if not exists (select 1 from [LOOPP].[Rol_X_Usuario] ru
				   inner join [LOOPP].[Usuarios] u on ru.id_usuario=u.id_usuario
				   inner join [LOOPP].[Espectaculos] e on u.id_usuario=e.id_usuario_responsable
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue on e.id_espectaculo=ue.id_espectaculo
				   where ru.id_rol=@idRol 
				   and (GETDATE() between e.fecha_publicacion and ue.fecha_espectaculo))
	begin
		update [LOOPP].[Rol_X_Usuario]
		set activo='False'
		where [id_rol]=@idRol;

		update [LOOPP].[Roles]
		set baja_logica = 'True'
		where id_rol=@idRol;

		set @resultado='OK'
	end
	else set @resultado='Error'

	Select @resultado;

GO

--------------------------------------------------------------------
/*LOOPP.SP_ModificarEmpresa*/

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
	GO
-----------------------------------------------------------------------------

