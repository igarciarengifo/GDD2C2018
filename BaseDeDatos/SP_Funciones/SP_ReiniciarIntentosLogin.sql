IF OBJECT_ID('LOOPP.SP_ReiniciarIntentosLogin', 'P') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ReiniciarIntentosLogin
GO

CREATE PROCEDURE LOOPP.SP_ReiniciarIntentosLogin 
	@id_user int
AS
BEGIN
	UPDATE LOOPP.Usuarios  
	SET loginFallidos = '0' 
	WHERE id_usuario = @id_user;  
END

GO