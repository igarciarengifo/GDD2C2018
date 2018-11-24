IF OBJECT_ID('LOOPP.SP_HabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_HabilitarRol
GO

CREATE PROCEDURE [LOOPP].[SP_SP_HabilitarRol] @idRol int
AS
	update [LOOPP].[Roles]
	set [estado] = 'True'
	where id_rol=@idRol

GO
