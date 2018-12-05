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
