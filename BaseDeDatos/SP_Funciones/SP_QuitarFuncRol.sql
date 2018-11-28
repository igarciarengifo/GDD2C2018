IF OBJECT_ID('LOOPP.SP_QuitarFuncDeRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_QuitarFuncDeRol
GO

CREATE PROCEDURE [LOOPP].[SP_QuitarFuncDeRol] @idRol int, @idFunc int
AS
	if exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc and baja_logica='False')
	begin
		update [LOOPP].[Func_X_Rol]
		set baja_logica = 'True'
		where id_funcionalidad=@idFunc and id_rol=@idRol;
	end
GO
