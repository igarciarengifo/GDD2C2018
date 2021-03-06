IF OBJECT_ID('LOOPP.SP_AltaUsuario_Autogenerado') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_AltaUsuario_Autogenerado];
GO

CREATE PROCEDURE [LOOPP].[SP_AltaUsuario_Autogenerado] ( @cuitCuil nvarchar(15), @nombre nvarchar(255))
AS
Begin
	DECLARE @id int, @nuevoUser varchar(255), @pass varchar(255)
	SET @nuevoUser = @cuitCuil
	SET @pass = @cuitCuil + '!' + @nombre
	INSERT INTO LOOPP.Usuarios (username, password)
	VALUES (@nuevoUser,@pass)
	SELECT @id=SCOPE_IDENTITY() 
	FROM [LOOPP].[Usuarios]	 
	RETURN @id
End
