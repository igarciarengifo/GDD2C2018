IF OBJECT_ID('LOOPP.SP_InsertarFuncXRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InsertarFuncXRol
GO

CREATE PROCEDURE [LOOPP].[SP_InsertarFuncXRol] @idRol int, @idFuncionalidad int
AS

	declare @resultado varchar(255)
	if not exists (select 1 from [LOOPP].[Func_X_Rol] where id_funcionalidad=@idFuncionalidad and id_rol=@idRol)
	begin
		Insert into [LOOPP].[Func_X_Rol](id_rol,id_funcionalidad)
		values (@idRol,@idFuncionalidad)

		set @resultado = 'OK'
	end
	else
		set @resultado = 'Error'

	select @resultado;

GO