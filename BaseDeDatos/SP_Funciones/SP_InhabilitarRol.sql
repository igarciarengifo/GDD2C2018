IF OBJECT_ID('LOOPP.SP_InhabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarRol
GO

CREATE PROCEDURE [LOOPP].[SP_InhabilitarRol] @idRol int
AS

	update [LOOPP].[Rol_X_Usuario]
	set activo='False'
	where [id_rol]=@idRol;

	update [LOOPP].[Roles]
	set [estado] = 'False'
	where id_rol=@idRol;

GO
