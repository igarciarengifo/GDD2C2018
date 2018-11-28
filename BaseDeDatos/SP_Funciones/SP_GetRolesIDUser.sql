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