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
CREATE PROCEDURE [LOOPP].[SP_ModificarGrado] @id int,@comision numeric(19,2),@descripcion nvarchar(20)
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.[id_espectaculo]=ue.[id_espectaculo]
				   where id_grado_publicacion=@id
				   and getdate() between e.[fecha_publicacion] and ue.[fecha_espectaculo])
		BEGIN
			update [LOOPP].[Grados_Publicacion]
			set [comision]= @comision,
				[descripcion]= @descripcion
			where id_grado_publicacion=@id

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
				   and getdate() between e.[fecha_publicacion] and ue.[fecha_espectaculo])
		BEGIN
			update [LOOPP].[Grados_Publicacion]
			set [activo]='False'
			where id_grado_publicacion=@id

			set @resultado='OK';
		END
	else set @resultado='ERROR'--EXISTEN PUBLICACIONES CON LA PRIORIDAD QUE SE QUIERE INHABILITAR
	select @resultado;
GO
