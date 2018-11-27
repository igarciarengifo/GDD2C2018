IF OBJECT_ID('LOOPP.SP_QuitarFuncRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_QuitarFuncRol
GO

CREATE PROCEDURE [LOOPP].[SP_QuitarFuncRol] @idRol int, @idFunc int
AS
	update [LOOPP].[Func_X_Rol]
	set baja = 'True'
	where id_funcionalidad=@idFunc and id_rol=@idRol;
GO
