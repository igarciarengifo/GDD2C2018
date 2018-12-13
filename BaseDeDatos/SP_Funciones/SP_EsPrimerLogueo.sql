CREATE PROCEDURE LOOPP.SP_EsPrimerLogueo (@id_user int)
as
begin
DECLARE @cuitCuil nvarchar(15), @nombre nvarchar(255), @pass varchar(255), @result bit
	SELECT @pass=password
	FROM LOOPP.Usuarios
	WHERE id_usuario=@id_user

	SELECT @cuitCuil=cuil, @nombre=nombre
	FROM LOOPP.Clientes
	WHERE id_usuario=@id_user

	SELECT @cuitCuil=cuit, @nombre=razon_social
	FROM LOOPP.Empresas
	WHERE id_usuario=@id_user
	
	if ( (@cuitCuil + '!' + @nombre) = @pass)
	
		set @result='true'
	
	else
		set @result='false'
	select @result
End
