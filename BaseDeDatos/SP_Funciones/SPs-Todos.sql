/*##########################################################################################################*/
/*										CREACION DE SPs y FN												*/
/*##########################################################################################################*/

-------------------------------------------------------------------

/*LOOPP.SP_AltaUsuario_Autogenerado*/

IF OBJECT_ID('LOOPP.SP_AltaUsuario_Autogenerado') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_AltaUsuario_Autogenerado];
GO

CREATE PROCEDURE [LOOPP].[SP_AltaUsuario_Autogenerado] ( @cuitCuil nvarchar(15), @nombre nvarchar(255))
AS
Begin
	DECLARE @id int, @nuevoUser varchar(255), @pass varchar(255)
	SET @nuevoUser = @cuitCuil
	SET @pass = '1234'
	INSERT INTO LOOPP.Usuarios (username, password,primerLoginAuto)
	VALUES (@nuevoUser,@pass, 'True')
	SELECT @id=SCOPE_IDENTITY() 
	FROM [LOOPP].[Usuarios]	 
	RETURN @id
End
GO
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
	declare @resultado varchar(255), @idUsu int, @idCliente int
	BEGIN TRANSACTION [T]

	BEGIN TRY
		/*En el momento de crear usuarios, el campo username tiene una constraint de unicidad, si ya existe uno igual dara error de constraint*/
		if ( @user is null)
			begin
				EXEC @idUsu =  LOOPP.SP_AltaUsuario_Autogenerado @cuil, @nombre

				select @pass = password, @user= username
				from LOOPP.usuarios
				where id_usuario = @idUsu
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

		if not exists (select 1 from [LOOPP].[Clientes] where (tipo_documento=@tipo_doc and nro_documento=@documento) or mail=@mail)
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
			SELECT @idCliente=SCOPE_IDENTITY()
			FROM LOOPP.Clientes
		end
		else
			RAISERROR('El cliente ya existe en el sistema',16,1)
	SET @resultado = 'OK'


	COMMIT TRANSACTION [T]

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]
			set @resultado = 'ERROR: '+ERROR_MESSAGE()
			SET @idCliente=0

	END CATCH;
	select @resultado as 'resultadoCliente',  @idUsu as 'id_usuario', @idCliente as 'id_cliente', @user as 'username', @pass as 'password'
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
	WHERE (C.nombre LIKE '%'+@nombre+'%' OR @nombre IS NULL OR @nombre = '')
	AND (C.apellido LIKE '%'+@apellido+'%' OR @apellido IS NULL OR @apellido = '')
	AND (C.mail LIKE '%'+@email+'%' OR @email IS NULL OR @email = '')
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
   ,@estaInhabilitado bit
  
  AS
	declare @resultado varchar(255), @iduser int, @estado nvarchar(50)
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
		select @iduser= id_usuario, @estado=estado
		from LOOPP.Clientes
		where id_cliente=@idCliente
		if (@estado = 'Inconsistente')
			 SET @estado = 'Habilitado'
	
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
			baja_logica=@baja_logica,
			estado=@estado
		WHERE id_cliente=@idCliente
	
		UPDATE LOOPP.Usuarios
			SET habilitado=~@estaInhabilitado
			where id_usuario=@iduser

		if (@baja_logica ='True')
			begin
				UPDATE LOOPP.Usuarios
					SET habilitado='False'
					WHERE id_usuario= @iduser
			end
		else
			begin
				UPDATE LOOPP.Usuarios
						SET habilitado='True'
						WHERE id_usuario= @iduser
			end
		

	
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

create function LOOPP.Fn_PrecioXUbicacion (@gradoPub int, @id_ubicacion int,@precioBase numeric(18,2))
RETURNS numeric(18,2)
AS 
	BEGIN
		declare @precioEntrada numeric(18,2);
		declare @porcXUbic numeric (10,2);
		declare @comision numeric (10,2);

		select @porcXUbic = porcentual
		from LOOPP.Ubicaciones u
		inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
		where id_ubicacion = @id_ubicacion

		select @comision=comision
		from [LOOPP].[Grados_Publicacion]
		where id_grado_publicacion=@gradoPub;

		set @precioEntrada = @precioBase + (@precioBase*@porcXUbic) + (@precioBase*@comision);
	
		RETURN @precioEntrada
	END
GO
/*Inserta ubicacion por espectaculo con el precio segun ubicacion*/
IF OBJECT_ID('LOOPP.SP_NuevaUbicac_X_Espectaculo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevaUbicac_X_Espectaculo
GO

create procedure LOOPP.SP_NuevaUbicac_X_Espectaculo 
						@id_espectaculo int
						,@id_ubicacion int
						,@id_grado_publicacion int
						,@precio_base numeric(18,2)
AS

	insert into [LOOPP].[Ubicac_X_Espectaculo] ([id_espectaculo]
											,[id_ubicacion]
											,[precio])
	values( @id_espectaculo
			  ,@id_ubicacion
			  ,LOOPP.Fn_PrecioXUbicacion(@id_grado_publicacion,@id_ubicacion,@precio_base))

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
										  ,@horaEspec nvarchar(50)
										  ,@fechaVenc date
AS
	declare @resultado int;
	declare @newId int;
	declare @timeEspec time;
	set @timeEspec = CONVERT( TIME, @horaEspec )
	select @newId=MAX([id_espectaculo])+1
	from [LOOPP].[Espectaculos];

	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.id_espectaculo=ue.id_espectaculo
				   where e.descripcion=@descripcion 
				   and e.fecha_publicacion=@fecha_publicacion
				   and e.fecha_espectaculo=@fechaEspec
				   and e.hora_espectaculo=@timeEspec
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
											,[precio_base]
											,[fecha_espectaculo]
											,[fecha_venc_espectaculo]
											,[hora_espectaculo])
		values (@newId,@id_usuario,@rubro,@fecha_publicacion,@descripcion,@direccion,@id_estado,@id_grado_publicacion,@precio_base,@fechaEspec, @fechaVenc, @timeEspec)

		set @resultado = @newId

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
			SET @resultado = CONVERT(varchar(255), @idUsu)+';1234'
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
			SET @resultado = CONVERT(varchar(255), @idUsu)+';'
	end
	INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
	VALUES (@idUsu,3);

	if not exists (select 1 from [LOOPP].[Empresas] where cuit=@cuit or [mail]=@email or [razon_social]=@razon)
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
	else
		RAISERROR('La empresa ya existe en el sistema',16,1)
	
COMMIT TRANSACTION [T]

set @resultado = @resultado +';OK';

END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION [T]

	set @resultado = ERROR_MESSAGE()+';;ERROR';

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
DECLARE @result bit, @esPrimerLogin bit
	
	SELECT @esPrimerLogin=primerLoginAuto
	FROM LOOPP.Usuarios
	WHERE id_usuario=@id_user

	if ( @esPrimerLogin='True')
	
		set @result='True'
	
	else
		set @result='False'
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
				   and (GETDATE() between e.fecha_publicacion and e.fecha_espectaculo))
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
	declare @resultado varchar(255), @idUser int
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
		IF EXISTS (SELECT 1 FROM LOOPP.Empresas  WHERE razon_social=@razon and id_empresa != @idEmpresa)
		BEGIN
			RAISERROR('Ya se encuentra registrado una empresa con la misma razon social',16,1)
		END
		select @iduser= id_usuario
			from LOOPP.Empresas
			where id_empresa=@idEmpresa
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

		if (@bajaLogica ='True')
			begin
				UPDATE LOOPP.Usuarios
					SET habilitado='False'
					WHERE id_usuario= @idUser
			end
		else
			begin
				UPDATE LOOPP.Usuarios
						SET habilitado='True'
						WHERE id_usuario= @idUser
			end
	
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
/* SP_ABM_GradoPublicacion */

/*Alta de un nuevo grado de publicacion*/
IF OBJECT_ID('[LOOPP].[SP_NuevoGrado]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_NuevoGrado]
GO
CREATE PROCEDURE [LOOPP].[SP_NuevoGrado] @comision numeric(10,2),@descripcion nvarchar(20)
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Grados_Publicacion] where descripcion=@descripcion and comision=@comision)
		BEGIN
			insert into [LOOPP].[Grados_Publicacion] ([comision],[descripcion])
			values (@comision,@descripcion)

			set @resultado='OK'
		END
	else set @resultado = 'ERROR'
	select @resultado;
GO

/*Modificacion de un grado de publicacion*/
IF OBJECT_ID('[LOOPP].[SP_ModificarGrado]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_ModificarGrado]
GO
CREATE PROCEDURE [LOOPP].[SP_ModificarGrado] @id int,@comision numeric(10,2),@descripcion nvarchar(20)
AS
	declare @resultado varchar(10);

	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.[id_espectaculo]=ue.[id_espectaculo]
				   where id_grado_publicacion=@id
				   and getdate() between e.[fecha_publicacion] and e.[fecha_espectaculo]
				   )
		BEGIN
			if @descripcion is null and @comision is not null
			begin
				update [LOOPP].[Grados_Publicacion]
				set [comision]= @comision
				where id_grado_publicacion=@id
			end
			if @descripcion is not null and @comision is null
			begin
				update [LOOPP].[Grados_Publicacion]
				set [descripcion]= @descripcion
				where id_grado_publicacion=@id
			end
			if @descripcion is not null and @comision is not null
			begin
				update [LOOPP].[Grados_Publicacion]
				set [comision]= @comision,
					[descripcion]= @descripcion
				where id_grado_publicacion=@id
			end

			set @resultado='OK';
		END
	else set @resultado='ERROR'--EXISTEN PUBLICACIONES CON LA PRIORIDAD QUE SE QUIERE MODIFICAR

	select @resultado;
GO

/*Baja logica de un grado de publicacion*/
IF OBJECT_ID('[LOOPP].[SP_BajaLogicaGrado]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_BajaLogicaGrado]
GO
CREATE PROCEDURE [LOOPP].[SP_BajaLogicaGrado] @id int
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.[id_espectaculo]=ue.[id_espectaculo]
				   where id_grado_publicacion=@id
				   and getdate() between e.[fecha_publicacion] and e.[fecha_espectaculo])
		BEGIN
			update [LOOPP].[Grados_Publicacion]
			set [activo]='False'
			where id_grado_publicacion=@id

			set @resultado='OK';
		END
	else set @resultado='ERROR'--EXISTEN PUBLICACIONES CON LA PRIORIDAD QUE SE QUIERE INHABILITAR
	select @resultado;
GO

-----------------------------------------------------------------------
/*LOOPP.SP_AgregarFuncRol*/

IF OBJECT_ID('LOOPP.SP_AgregarFuncRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_AgregarFuncRol
GO

CREATE PROCEDURE [LOOPP].[SP_AgregarFuncRol] @idRol int, @idFunc int
AS
	declare @resultado varchar(10);

	if not exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc)
		begin
			insert into [LOOPP].[Func_X_Rol](id_rol,id_funcionalidad)
			values (@idRol,@idFunc);

			set @resultado='OK';
		end
	else
		begin
		if exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc)
			begin
				update [LOOPP].[Func_X_Rol]
				set baja_logica = 'False'
				where id_rol=@idRol 
				and id_funcionalidad=@idFunc;

				set @resultado='OK';
			end
		else set @resultado='ERROR';
		end
	
	select @resultado;
GO
------------------------------------------------------------------------
/*LOOPP.SP_AltaNuevoRol*/

IF OBJECT_ID('[LOOPP].[SP_AltaNuevoRol]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AltaNuevoRol]
GO
CREATE PROCEDURE [LOOPP].[SP_AltaNuevoRol] @nombre varchar(50)
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Roles] where nombre=@nombre)
		BEGIN
			insert into [LOOPP].[Roles] (nombre)
			values (@nombre)
			
			SELECT @resultado = max(id_rol)
			from [LOOPP].[Roles]

		END
	else set @resultado = 'ERROR'

	select @resultado;

GO

-----------------------------------------------------------------------
/*LOOPP.SP_DevuelveItemsPorIdFactura*/

IF OBJECT_ID('LOOPP.SP_DevuelveItemsPorIdFactura') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_DevuelveItemsPorIdFactura];
GO

CREATE PROCEDURE [LOOPP].[SP_DevuelveItemsPorIdFactura] @idFactura int
AS
	select 		  comp.fecha_compra
				  ,tub.descripcion+' - Fila '+ub.fila+' - Asiento '+cast(ub.asiento as varchar(10))+' '+case when ub.sin_numerar=1 then 'Sin numero' else '' end ubicacion
				  ,sum(comp.importe_total) importe_total
				  ,sum(comp.cantidad_compra) cantidad_compra
				  ,SUM([LOOPP].[Fn_CalcularComision](comp.importe_total,esp.id_grado_publicacion)) comision
			from [LOOPP].[Item_Factura] ifact
			left join [LOOPP].[Facturas] fact
				on ifact.nro_factura=fact.nro_factura
			inner join [LOOPP].[Espectaculos] esp
				on fact.id_espectaculo=esp.id_espectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Ubicaciones] ub
				on uesp.id_ubicacion=ub.id_ubicacion
			inner join [LOOPP].[Tipo_Ubicacion] tub
				on ub.id_tipo_ubicacion=tub.id_tipo_ubicacion
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where ifact.nro_factura = @idFactura
			group by comp.fecha_compra
					,tub.descripcion+' - Fila '+ub.fila+' - Asiento '+cast(ub.asiento as varchar(10))+' '+case when ub.sin_numerar=1 then 'Sin numero' else '' end
GO

--------------------------------------------------------------------------------
/* LOOPP.SP_FiltrarEmpresas*/

IF OBJECT_ID('LOOPP.SP_FiltrarEmpresas') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_FiltrarEmpresas];
GO

CREATE PROCEDURE [LOOPP].[SP_FiltrarEmpresas]
	@cuit nvarchar(255),
	@razon_soc nvarchar(255),
	@email nvarchar(50)
AS
BEGIN
	SELECT E.id_empresa, E.razon_social, E.cuit, E.mail, E.telefono, E.direccion_calle, E.direccion_nro, E.ciudad, E.baja_logica
	FROM [LOOPP].Empresas as E
	WHERE (E.cuit = @cuit OR @cuit IS NULL OR @cuit = '')
	AND (E.razon_social LIKE '%'+@razon_soc+'%' OR @razon_soc IS NULL OR @razon_soc = '')
	AND (E.mail LIKE '%'+@email+'%' OR @email IS NULL OR @email = '')
	
END
GO

------------------------------------------------------------------------------------
/*LOOPP.SP_Funcionalidad_X_Rol*/

IF OBJECT_ID('LOOPP.SP_Funcionalidad_X_Rol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_Funcionalidad_X_Rol
GO

CREATE PROCEDURE [LOOPP].[SP_Funcionalidad_X_Rol]	@id_rol	int
AS
BEGIN
	select F.id_funcionalidad, F.nombre 
	from [LOOPP].[Funcionalidades] F 
	JOIN [LOOPP].[Func_X_Rol] FR ON (FR.ID_Funcionalidad = F.id_funcionalidad)
	JOIN [LOOPP].[Roles] R ON (R.id_rol=FR.id_rol)
	WHERE R.id_rol=@id_rol
	AND FR.baja_logica = 'False'
END
GO
---------------------------------------------------------------------------------------

/*LOOPP.SP_GetAllFuncionalidad*/

IF OBJECT_ID('LOOPP.SP_GetAllFuncionalidad') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllFuncionalidad
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllFuncionalidad]
AS
	select * from [LOOPP].[Funcionalidades]
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetAllRoles*/

IF OBJECT_ID('LOOPP.SP_GetAllRoles') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllRoles
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllRoles]
AS

	SELECT * 
	FROM [LOOPP].[Roles]

GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetAllRolesHab*/

IF OBJECT_ID('LOOPP.SP_GetAllRolesHab') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllRolesHab
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllRolesHab]
AS
BEGIN
	SELECT * FROM LOOPP.Roles
	WHERE baja_logica='False'
	ORDER BY nombre
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetRolesIDUser*/

IF OBJECT_ID('LOOPP.SP_GetRolesIDUser') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetRolesIDUser];
GO

CREATE PROCEDURE [LOOPP].[SP_GetRolesIDUser]
	@id_user int
AS
BEGIN
	select * from [LOOPP].[Roles] R
	JOIN [LOOPP].Rol_X_Usuario as RxU on R.id_rol=RxU.id_rol 
	where id_usuario=@id_user
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetUsuario*/

IF OBJECT_ID('LOOPP.SP_GetUsuario') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetUsuario];
GO

CREATE PROCEDURE [LOOPP].[SP_GetUsuario]
	@username varchar(255)
AS
BEGIN
	select * from [LOOPP].[Usuarios] U
	where username=@username
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_HabilitarRol */

IF OBJECT_ID('LOOPP.SP_HabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_HabilitarRol
GO

CREATE PROCEDURE [LOOPP].[SP_HabilitarRol] @idRol int
AS
	update [LOOPP].[Roles]
	set baja_logica = 'False'
	where id_rol=@idRol

GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_InhabilitarFunc_X_idRol */

IF OBJECT_ID('LOOPP.SP_InhabilitarFunc_X_idRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarFunc_X_idRol
GO

CREATE PROCEDURE [LOOPP].[SP_InhabilitarFunc_X_idRol] @id_rol int
AS
	BEGIN
		update [LOOPP].[Func_X_Rol]
		set baja_logica = 'True'
		WHERE id_rol=@id_rol;
	END
GO
---------------------------------------------------------------------------------------
/*LOOPP.SP_QuitarFuncDeRol */

IF OBJECT_ID('LOOPP.SP_QuitarFuncDeRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_QuitarFuncDeRol
GO

CREATE PROCEDURE [LOOPP].[SP_QuitarFuncDeRol] @idRol int, @idFunc int
AS
	if exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc and baja_logica='False')
	begin
		update [LOOPP].[Func_X_Rol]
		set baja_logica = 'True'
		where id_funcionalidad=@idFunc and id_rol=@idRol;
	end
GO

---------------------------------------------------------------------------------------
/* SP_GenerarRendicionComision */

/*Retorna valor de comision por total de compra*/
IF OBJECT_ID('[LOOPP].[Fn_CalcularComision]') IS NOT NULL
    DROP Function [LOOPP].[Fn_CalcularComision]
GO
CREATE FUNCTION [LOOPP].[Fn_CalcularComision] (@Importe_total numeric (18,0), @idPrioridad int)
RETURNS numeric(10,2)
AS 
	BEGIN
		declare @comision numeric(10,2)
		
		select @comision=(@Importe_total*comision)
		from [LOOPP].[Grados_Publicacion]
		where id_grado_publicacion=@idPrioridad
	
		RETURN @comision
	END
GO

/*Generar rendicion de comisiones*/
IF OBJECT_ID('[LOOPP].[SP_GenerarRendicionComision]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GenerarRendicionComision]
GO
CREATE PROCEDURE [LOOPP].[SP_GenerarRendicionComision] @idEmpresa int, @idEspectaculo int, @cantidad int
AS
	BEGIN TRANSACTION [T]

	BEGIN TRY

		select top (@cantidad)
		           comp.id_compra
				  ,esp.id_espectaculo
				  ,emp.id_empresa
				  ,comp.fecha_compra
				  ,comp.importe_total
				  ,comp.cantidad_compra
				  ,[LOOPP].[Fn_CalcularComision](comp.importe_total,esp.id_grado_publicacion) comision
			into #Temp_Rendicion
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario 
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable 
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where emp.id_empresa=@idEmpresa
			and esp.id_espectaculo=@idEspectaculo
			group by comp.id_compra
					,esp.id_espectaculo
					,emp.id_empresa
					,comp.fecha_compra
					,comp.importe_total
					,comp.cantidad_compra
					,[LOOPP].[Fn_CalcularComision](comp.importe_total,esp.id_grado_publicacion)
			order by comp.fecha_compra asc
		
		declare @newId int;
		select @newId=MAX([nro_factura])+1 from [LOOPP].[Facturas];

		insert into [LOOPP].[Facturas]([nro_factura],[id_empresa],[id_espectaculo],[fecha_factura],[total_factura],[total_comision])
		select @newId,id_empresa,id_espectaculo,GETDATE(),SUM(importe_total),SUM(comision)
		from #Temp_Rendicion
		group by id_empresa,id_espectaculo
		
		insert into [LOOPP].[Item_Factura]([nro_factura],[monto_compra],[monto_comision],[cantidad],[descripcion])
		select @newId,importe_total,comision,cantidad_compra,'Comision por compra'
		from #Temp_Rendicion

		update LOOPP.Compras
		set facturado = 'True'
		where id_compra in (select id_compra from #Temp_Rendicion)
			
	COMMIT TRANSACTION [T]

	select fa.*,emp.razon_social
	from [LOOPP].[Facturas] fa
	inner join [LOOPP].[Empresas] emp
	on fa.id_empresa=emp.id_empresa
	where nro_factura=@newId;

	drop table #Temp_Rendicion;

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  print 'Error: ' + ERROR_MESSAGE();

	END CATCH;
GO

---------------------------------------------------------------------------------------
/*[LOOPP].[SP_GetAllGradosActivos */

IF OBJECT_ID('LOOPP.SP_GetAllGradosActivos') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllGradosActivos
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllGradosActivos]
AS
BEGIN
	SELECT * FROM [LOOPP].[Grados_Publicacion]
	WHERE [activo]=1
	ORDER BY descripcion
END
GO

---------------------------------------------------------------------------------------
/*SP_AllComprasPorEmpEsp */

IF OBJECT_ID('[LOOPP].[SP_AllComprasPorEmpresa]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllComprasPorEmpresa]
GO
CREATE PROCEDURE [LOOPP].[SP_AllComprasPorEmpresa] @idEmpresa int,@idEspectaculo int
AS
BEGIN
	if (@idEspectaculo is not null)
		begin
			select comp.id_compra
				  ,esp.descripcion Espectaculo
				  ,comp.fecha_compra [Fecha Compra]
				  ,comp.importe_total [Importe Total]
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable and esp.id_espectaculo=@idEspectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where comp.facturado='False'
			group by comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total
			order by comp.fecha_compra asc
		end

	else
		begin
			select comp.id_compra
				  ,esp.descripcion Espectaculo
				  ,comp.fecha_compra [Fecha Compra]
				  ,comp.importe_total [Importe Total]
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable --and esp.id_espectaculo=@idEspectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where comp.facturado='False'
			group by comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total
			order by comp.fecha_compra asc
		end
END
GO


---------------------------------------------------------------------------------------
/* SP_EmpresasActivas y Espectaculos por Empresa */

/*SP que devuelve todas las empresas activas*/
IF OBJECT_ID('[LOOPP].[SP_AllEmpresasActivas]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllEmpresasActivas]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEmpresasActivas]
AS
BEGIN
	select [id_empresa],[razon_social]
	from [LOOPP].[Empresas]
	where [baja_logica] = 'False'
	order by right(razon_social,2)

END
GO

/*SP que devuelve todos los espectaculos de una empresa*/
IF OBJECT_ID('[LOOPP].[SP_AllEspectaculosPorIdEmpresa]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdEmpresa]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdEmpresa] @idEmpresa int
AS
BEGIN
	select [id_espectaculo],[descripcion]
	from [LOOPP].[Empresas] emp
	inner join [LOOPP].[Usuarios] usu
	on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
	inner join [LOOPP].[Espectaculos] esp
	on usu.id_usuario=esp.id_usuario_responsable
	group by [id_espectaculo],[descripcion]

END
GO


---------------------------------------------------------------------------------------
/* SP_FiltrarEspectaculos para compra */
/*SP que devuelve consulta con compras segun id seleccionadas en la APP*/
IF OBJECT_ID('[LOOPP].[SP_RetornaCategoriasSegunIdList]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_RetornaCategoriasSegunIdList]
GO
CREATE PROCEDURE [LOOPP].[SP_RetornaCategoriasSegunIdList] @idList varchar(100)
AS
BEGIN

	DECLARE @SQL varchar(max)

	SET @SQL = 
			'select *
			from [LOOPP].[Rubros]
			where [id_rubro] IN (' + @idList + ')'

	EXEC(@SQL)	
END
GO

/*Devuelve espectaculos para realizar compra*/
IF OBJECT_ID('[LOOPP].[SP_FiltrarEspectaculos]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_FiltrarEspectaculos]
GO
CREATE PROCEDURE [LOOPP].[SP_FiltrarEspectaculos] @idEspectaculo int, @idList varchar(100), @desde varchar(15), @hasta varchar(15)
AS
BEGIN
	
	if (@idEspectaculo is not null)
	begin

		select esp.id_espectaculo
			  ,esp.descripcion Espectaculo
			  ,esp.fecha_espectaculo [Fecha Espectaculo]
			  ,esp.hora_espectaculo [Horarios]
		from [LOOPP].[Espectaculos] esp
		inner join [LOOPP].[Estados_Publicacion] estado
			on esp.id_estado_publicacion=estado.id_estado_publicacion and estado.descripcion='Publicada'
		inner join [LOOPP].[Grados_Publicacion] grado
			on esp.id_grado_publicacion=grado.id_grado_publicacion
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		where esp.id_espectaculo=@idEspectaculo 
		and esp.fecha_espectaculo between cast(@desde as date) and cast(@hasta as date)
		group by esp.id_espectaculo,esp.descripcion,grado.id_grado_publicacion,esp.fecha_espectaculo,esp.hora_espectaculo
		order by grado.id_grado_publicacion
	end

	if (@idEspectaculo is null and @idList is not null)
	begin

		/*Genero tabla temporal con los registros obtenidos*/
		CREATE TABLE #Temp_Rubros (	[id_rubro] int NOT NULL,
									[descripcion] varchar(20) NOT NULL)

		insert into #Temp_Rubros ([id_rubro],[descripcion]) 
		exec [LOOPP].[SP_RetornaCategoriasSegunIdList] @idList;

		select esp.id_espectaculo
			  ,esp.descripcion Espectaculo
			  ,esp.fecha_espectaculo [Fecha Espectaculo]
			  ,esp.hora_espectaculo [Horarios]
		from [LOOPP].[Espectaculos] esp
		inner join #Temp_Rubros rubros
		on esp.id_rubro=rubros.id_rubro
		inner join [LOOPP].[Estados_Publicacion] estado
			on esp.id_estado_publicacion=estado.id_estado_publicacion and estado.descripcion='Publicada'
		inner join [LOOPP].[Grados_Publicacion] grado
			on esp.id_grado_publicacion=grado.id_grado_publicacion
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		where esp.fecha_espectaculo between cast(@desde as date) and cast(@hasta as date)
		group by esp.id_espectaculo,esp.descripcion,grado.id_grado_publicacion,esp.fecha_espectaculo,esp.hora_espectaculo
		order by grado.id_grado_publicacion
	end
END
GO

---------------------------------------------------------------------------------------
/*Historial de compras del cliente*/

IF OBJECT_ID('[LOOPP].[SP_HistorialComprasCliente]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_HistorialComprasCliente]
GO
CREATE PROCEDURE [LOOPP].[SP_HistorialComprasCliente] @idUsuario int
AS
	select	comp.fecha_compra [Fecha Compra], 
			esp.descripcion [Espectaculo], 
			esp.fecha_espectaculo [Fecha Espectaculo], 
			comp.importe_total [Importe Total], 
			fp.descripcion [Forma de Pago], 
			ub.fila [Fila], 
			ub.asiento [Asiento]
	from LOOPP.Compras comp
	inner join LOOPP.Clientes cli on cli.id_cliente=comp.id_cliente
	inner join LOOPP.Localidades_Vendidas lcv on lcv.id_compra=comp.id_compra
	inner join LOOPP.Espectaculos esp on esp.id_espectaculo=lcv.id_espectaculo
	inner join LOOPP.Ubicaciones ub on lcv.id_ubicacion=ub.id_ubicacion
	inner join LOOPP.Formas_Pago_Cliente fpc on fpc.id_forma_pago_cliente=comp.id_forma_pago_cliente
	inner join LOOPP.Formas_Pago fp on fp.id_forma_pago = fpc.id_forma_pago
	where id_usuario=@idUsuario
	group by comp.id_compra, comp.fecha_compra, esp.descripcion, esp.fecha_espectaculo, comp.importe_total,fp.descripcion, ub.fila, ub.asiento

	order by comp.id_compra
GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllEstadosPublicacion */
IF OBJECT_ID('LOOPP.SP_GetAllEstadosPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllEstadosPublicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllEstadosPublicacion
AS
	SELECT * from LOOPP.Estados_Publicacion
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetAllUbicaciones */

IF OBJECT_ID('LOOPP.SP_GetAllUbicaciones') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllUbicaciones
GO
CREATE PROCEDURE LOOPP.SP_GetAllUbicaciones
AS
	SELECT id_ubicacion, T_U.descripcion + '-' +fila+LTRIM(RTRIM(STR(asiento))) as descripcion, fila, asiento, sin_numerar, u.id_tipo_ubicacion
	 from LOOPP.Ubicaciones U
	 INNER JOIN Tipo_Ubicacion T_U on T_U.id_tipo_ubicacion=U.id_tipo_ubicacion
GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllGradosPublicacion */

IF OBJECT_ID('LOOPP.SP_GetAllGradosPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllGradosPublicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllGradosPublicacion
AS
	SELECT * from LOOPP.Grados_Publicacion
GO
---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllRubros */

IF OBJECT_ID('LOOPP.SP_GetAllRubros') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllRubros
GO
CREATE PROCEDURE LOOPP.SP_GetAllRubros
AS
	SELECT * from LOOPP.Rubros
GO
---------------------------------------------------------------------------------------
/*LOOPP.Fn_CalcularPuntos */

IF OBJECT_ID('LOOPP.Fn_CalcularPuntos') IS NOT NULL
    DROP FUNCTION LOOPP.Fn_CalcularPuntos
GO

CREATE FUNCTION [LOOPP].[Fn_CalcularPuntos] (@Importe_total numeric (18,0))
RETURNS int
AS BEGIN
		declare @puntos int
	set @puntos = ( @Importe_total /10)
	
    RETURN @puntos
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_NuevoIntentoFallido */

IF OBJECT_ID('LOOPP.SP_NuevoIntentoFallido') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevoIntentoFallido
GO
CREATE PROCEDURE LOOPP.SP_NuevoIntentoFallido
	@id_user int
AS
BEGIN
	UPDATE LOOPP.Usuarios
	SET loginFallidos= loginFallidos + 1 
	WHERE id_usuario=@id_user
END
GO


---------------------------------------------------------------------------------------
/* LOOPP.SP_ReiniciarIntentosLogin */

IF OBJECT_ID('LOOPP.SP_ReiniciarIntentosLogin', 'P') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ReiniciarIntentosLogin
GO

CREATE PROCEDURE LOOPP.SP_ReiniciarIntentosLogin 
	@id_user int
AS
BEGIN
	UPDATE LOOPP.Usuarios  
	SET loginFallidos = '0' 
	WHERE id_usuario = @id_user;  
END

GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_CambiarPassword */

IF OBJECT_ID('LOOPP.SP_CambiarPassword') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_CambiarPassword
GO
CREATE PROCEDURE LOOPP.SP_CambiarPassword
	@newPass varchar(255),
	@id_usuario int
	
AS
BEGIN
	declare @esPrimerLogueo bit
	SELECT @esPrimerLogueo=primerLoginAuto
	FROM LOOPP.Usuarios
	WHERE id_usuario = @id_usuario
	if (@esPrimerLogueo='True')
		begin
			UPDATE LOOPP.Usuarios 
				SET password=@newPass,
					primerLoginAuto='False'
				WHERE id_usuario=@id_usuario
		end
	else
		begin
			UPDATE LOOPP.Usuarios
			SET password=@newPass
			WHERE id_usuario=@id_usuario
	end
END
GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllTiposUbicacion */

IF OBJECT_ID('LOOPP.SP_GetAllTiposUbicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllTiposUbicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllTiposUbicacion
AS
	SELECT *
	 from LOOPP.Tipo_Ubicacion
GO
--------------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.[SP_AllEspectaculosPorIdUsuario]') IS NOT NULL
    DROP PROCEDURE LOOPP.[SP_AllEspectaculosPorIdUsuario]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdUsuario] @idUsuario int
AS
BEGIN
	select [id_espectaculo],esp.[descripcion] as 'Descripcion' ,fecha_publicacion as 'Fecha de publicacion', fecha_espectaculo as 'Fecha de espectaculo', hora_espectaculo as 'Horario de espectaculo', direccion as 'Direccion', estP.descripcion as 'Estado Publicacion'
	from Espectaculos esp
	inner join LOOPP.Estados_Publicacion estP on estP.id_estado_publicacion=esp.id_estado_publicacion
	where esp.id_usuario_responsable=@idUsuario
	group by [id_espectaculo],esp.[descripcion], fecha_publicacion, direccion, estP.descripcion, fecha_espectaculo, hora_espectaculo
	
END

GO

---------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetEspectaculoFiltradoPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEspectaculoFiltradoPorId
GO

CREATE PROCEDURE [LOOPP].[SP_GetEspectaculoFiltradoPorId] @idEspectaculo int
AS
BEGIN
	select [id_espectaculo],esp.[descripcion] as 'Descripcion' ,fecha_publicacion as 'Fecha de publicacion', fecha_espectaculo as 'Fecha de espectaculo', hora_espectaculo as 'Horario de espectaculo', direccion as 'Direccion', estP.descripcion as 'Estado Publicacion'
	from Espectaculos esp
	inner join LOOPP.Estados_Publicacion estP on estP.id_estado_publicacion=esp.id_estado_publicacion
	where id_espectaculo = @idEspectaculo
	group by [id_espectaculo],esp.[descripcion], fecha_publicacion, direccion, estP.descripcion, fecha_espectaculo, hora_espectaculo
END

GO
-------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetEspectaculoPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEspectaculoPorId
GO

CREATE PROCEDURE [LOOPP].[SP_GetEspectaculoPorId] @idEspectaculo int
AS
BEGIN
	select * from LOOPP.Espectaculos
	where id_espectaculo = @idEspectaculo
END

GO

---------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetUbicacionesEspectaculo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetUbicacionesEspectaculo
GO

CREATE PROCEDURE [LOOPP].[SP_GetUbicacionesEspectaculo] @id_espectaculo int
AS
BEGIN
	select u.id_ubicacion, T_U.descripcion + '-' +fila+LTRIM(RTRIM(STR(asiento))) as descripcion, fila, asiento, sin_numerar, u.id_tipo_ubicacion
	from LOOPP.Ubicaciones u
	INNER JOIN Tipo_Ubicacion T_U on T_U.id_tipo_ubicacion=U.id_tipo_ubicacion
	inner join Ubicac_X_Espectaculo uxe on uxe.id_espectaculo=@id_espectaculo and uxe.id_ubicacion=u.id_ubicacion

END

GO

-----------------------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_ModificarPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ModificarPublicacion
GO
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
GO

---------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_BloquearUsuario') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_BloquearUsuario
GO

CREATE PROCEDURE [LOOPP].[SP_BloquearUsuario] @id_usuario int
AS
BEGIN
	UPDATE LOOPP.Usuarios
	SET habilitado='False'
	where id_usuario=@id_usuario
END

GO
------------------------------------------------------------------
/*Retorna medio de pagos validos*/


IF OBJECT_ID('LOOPP.SP_GetFormasPagoValidas') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetFormasPagoValidas
GO

CREATE PROCEDURE [LOOPP].[SP_GetFormasPagoValidas] 
AS
	select *
	from [LOOPP].[Formas_Pago] 
	where descripcion != 'Efectivo'
GO

-------------------------------------------------------------------
/*Retorna los Medios de pago por cliente*/
IF OBJECT_ID('LOOPP.SP_GetMedioPagoXCliente') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetMedioPagoXCliente
GO

CREATE PROCEDURE [LOOPP].[SP_GetMedioPagoXCliente] @idCliente int
AS
	select *
	from [LOOPP].[Formas_Pago_Cliente] fpc
	inner join LOOPP.Formas_Pago fp on fp.id_forma_pago=fpc.id_forma_pago
	where id_cliente=@idCliente 
	and fp.descripcion != 'Efectivo'
GO
---------------------------------------------------------------------

/*Inserta medio de pago asociado para un cliente */
IF OBJECT_ID('LOOPP.SP_InsertarMedioPago') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InsertarMedioPago
GO

CREATE PROCEDURE [LOOPP].[SP_InsertarMedioPago] @idCliente int,@idFormaPago int, @nro bigint
AS
	declare @resultado varchar(55);

	if not exists (select 1 from [LOOPP].[Formas_Pago_Cliente]
				   where [nro_tarjeta]=@nro)
		begin

			insert into [LOOPP].[Formas_Pago_Cliente]([id_cliente], [id_forma_pago], [nro_tarjeta])
			values (@idCliente, @idFormaPago, @nro)

			set @resultado = 'OK'
		end
	else set @resultado = 'ERROR. No pudo agregarse el medio de pago porque ya existe en el sistema.'

	select @resultado;
GO

------------------------------------------------------------------------------

/*Elimina medio de pago asociado para un cliente */
IF OBJECT_ID('LOOPP.SP_EliminarMedioPagoCliente') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_EliminarMedioPagoCliente
GO

CREATE PROCEDURE [LOOPP].[SP_EliminarMedioPagoCliente] @idFormaPagoCliente int
AS
	declare @resultado varchar(55);
	BEGIN TRANSACTION [T]

	BEGIN TRY
		DELETE LOOPP.Formas_Pago_Cliente
		WHERE id_forma_pago_cliente=@idFormaPagoCliente

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = 'No pudo agregarse el medio de pago: '+ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
GO


--------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetCatalogo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetCatalogo
GO

CREATE PROCEDURE [LOOPP].[SP_GetCatalogo]
AS
BEGIN
	select id_codigo, stock as 'Stock', descripcion as 'Descripcion', puntos_validos as 'Puntos necesarios'
	from LOOPP.Catalogo_Canjes
END

GO
--------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetPuntosClienteConIdUsuario') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetPuntosClienteConIdUsuario
GO

CREATE PROCEDURE [LOOPP].[SP_GetPuntosClienteConIdUsuario] @idUsuario int
AS
BEGIN
	select puntos_acumulados
	from LOOPP.Clientes c
	where c.id_usuario= @idUsuario
END

GO
--------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_CanjearProducto') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_CanjearProducto
GO

CREATE PROCEDURE [LOOPP].[SP_CanjearProducto] @idProducto int, @idUsuario int, @fechaCanje datetime
AS
BEGIN
	DECLARE @puntosCanjeados int, @idCanje int, @idCliente int, @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		UPDATE LOOPP.Catalogo_Canjes
			SET stock = stock - 1
		WHERE id_codigo = @idProducto

		SELECT @puntosCanjeados=puntos_validos
		FROM LOOPP.Catalogo_Canjes
		WHERE id_codigo=@idProducto

		SELECT @idCliente=id_cliente
		FROM LOOPP.Clientes
		WHERE id_usuario=@idUsuario

		UPDATE LOOPP.Clientes
			SET puntos_acumulados= puntos_acumulados-@puntosCanjeados
		WHERE id_usuario=@idUsuario

		INSERT INTO LOOPP.Canjes(fecha_canje, puntos_canjeados, id_codigo, id_cliente)
		VALUES (@fechaCanje, @puntosCanjeados, @idProducto, @idCliente)
		
		SELECT @idCanje=SCOPE_IDENTITY() 
		FROM LOOPP.Canjes

	COMMIT TRANSACTION [T]

	set @resultado = 'OK;'+CONVERT(varchar(255),@idCanje)

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado ='ERROR;' +ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
END

GO
--------------------------------------------------------------------------------

/*SP que modifica descripcion de rol cuando el rol esta activo, en caso de estar de baja retorna error*/
IF OBJECT_ID('[LOOPP].[SP_ModificarDescRol]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_ModificarDescRol]
GO
CREATE PROCEDURE [LOOPP].[SP_ModificarDescRol] @id int,@descripcion varchar(50)
AS
	declare @resultado varchar(10);

	if not exists (select 1 from [LOOPP].[Roles] where id_rol=@id and baja_logica = 1)
	begin
		update [LOOPP].[Roles]
		set [nombre]= @descripcion
		where id_rol=@id
		and baja_logica != 1

		set @resultado = 'OK'
	end
	else set @resultado='ERROR'
	
	select @resultado; 

GO
--------------------------------------------------------------------------------

/*SP que devuelve tipos de ubicacion disponible segun espectaculo*/
IF OBJECT_ID('[LOOPP].[SP_GetTipoUbicXEspect]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GetTipoUbicXEspect]
GO
CREATE PROCEDURE [LOOPP].[SP_GetTipoUbicXEspect] @id int,@fecha date,@hora time
AS
	select distinct tu.*
	from [LOOPP].[Ubicac_X_Espectaculo] ue
	inner join [LOOPP].[Espectaculos] e
	on ue.id_espectaculo=e.id_espectaculo
	inner join [LOOPP].[Ubicaciones] u
	on ue.id_ubicacion=u.id_ubicacion
	inner join [LOOPP].[Tipo_Ubicacion] tu
	on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
	where e.id_espectaculo=@id 
	and e.fecha_espectaculo=@fecha 
	and e.hora_espectaculo=@hora
	and ue.disponible = 1

GO
--------------------------------------------------------------------------------

/*SP que devuelve las ubicaciones segun espectaculo y tipo de ubicacion seleccionado*/
IF OBJECT_ID('[LOOPP].[SP_GetUbicacionesXEspec]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GetUbicacionesXEspec]
GO
CREATE PROCEDURE [LOOPP].[SP_GetUbicacionesXEspec] @id int,@fecha date,@hora time,@idTipoUbic int
AS
	select distinct u.id_ubicacion,'Fila '+[fila]+' - Asiento'+cast([asiento] as varchar(10)) Ubicacion
	from [LOOPP].[Ubicac_X_Espectaculo] ue
	inner join [LOOPP].[Espectaculos] e
	on ue.id_espectaculo=e.id_espectaculo
	inner join [LOOPP].[Ubicaciones] u
	on ue.id_ubicacion=u.id_ubicacion
	inner join [LOOPP].[Tipo_Ubicacion] tu
	on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
	where e.id_espectaculo=@id 
	and e.fecha_espectaculo=@fecha 
	and e.hora_espectaculo=@hora
	and ue.disponible = 1
	and tu.id_tipo_ubicacion=@idTipoUbic

GO
----------------------------------------------------

IF OBJECT_ID('LOOPP.SP_GetHistorialCanje') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetHistorialCanje
GO

CREATE PROCEDURE [LOOPP].[SP_GetHistorialCanje] @idUsuario int
AS
BEGIN
	select can.id_canje as 'Codigo', fecha_canje as 'Fecha de Canje', cli.nombre+' '+cli.apellido as 'Responsable', cc.descripcion as 'Producto Canjeado', can.puntos_canjeados as 'Puntos canjeados'
	from LOOPP.Canjes can
	inner join Clientes cli on cli.id_cliente=can.id_cliente 
	inner join Catalogo_Canjes cc on cc.id_codigo=can.id_codigo
	where cli.id_usuario= @idUsuario
END

GO
--------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_EsUsuarioHabilitado') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_EsUsuarioHabilitado
GO

CREATE PROCEDURE [LOOPP].[SP_EsUsuarioHabilitado] @id_cliente int
AS
BEGIN
	select habilitado
	from LOOPP.Usuarios usu
	inner join Clientes cli on cli.id_usuario=usu.id_usuario
	where cli.id_cliente=@id_cliente
END

GO

