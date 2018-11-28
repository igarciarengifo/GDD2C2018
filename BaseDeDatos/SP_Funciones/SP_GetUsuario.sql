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