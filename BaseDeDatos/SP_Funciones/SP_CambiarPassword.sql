IF OBJECT_ID('LOOPP.SP_CambiarPassword') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_CambiarPassword
GO
CREATE PROCEDURE LOOPP.SP_CambiarPassword
	@newPass varchar(255),
	@id_usuario int
	
AS
BEGIN
	UPDATE LOOPP.Usuarios
	SET password=@newPass
	WHERE id_usuario=@id_usuario
END
GO