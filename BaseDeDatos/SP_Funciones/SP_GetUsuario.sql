CREATE PROCEDURE [LOOPP].[SP_GetUsuario]
	@username varchar(255)
AS
BEGIN
	select * from [LOOPP].[Usuarios] U
	where username=@username
END
GO