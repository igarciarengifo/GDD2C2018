IF OBJECT_ID('LOOPP.SP_InhabilitarFunc_X_idRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarFunc_X_idRol
GO

CREATE PROCEDURE [LOOPP].[SP_InhabilitarFunc_X_idRol] @id_rol int
AS
BEGIN
	update [LOOPP].[Roles] 
	set baja_logica = 'True'
	WHERE id_rol=@id_rol;
END
GO
