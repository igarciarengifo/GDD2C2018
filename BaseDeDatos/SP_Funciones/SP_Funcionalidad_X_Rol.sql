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
END
GO
