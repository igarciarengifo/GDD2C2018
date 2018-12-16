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