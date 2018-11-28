
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