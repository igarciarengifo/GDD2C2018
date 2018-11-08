IF OBJECT_ID('LOOPP.SP_NuevoIntentoFallido') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevoIntentoFallido
GO
CREATE PROCEDURE LOOPP.SP_NuevoIntentoFallido
	@id_user int
AS
BEGIN
	UPDATE LOOPP.Usuarios
	SET loginFallidos= (loginFallidos + 1 )
	WHERE id_usuario=@id_user
END
GO
