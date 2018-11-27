IF OBJECT_ID('LOOPP.SP_AgregarFuncRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_AgregarFuncRol
GO

CREATE PROCEDURE [LOOPP].[SP_AgregarFuncRol] @idRol int, @idFunc int
AS
	declare @resultado varchar(50);
	if not exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc)
	begin
		insert into [LOOPP].[Func_X_Rol](id_rol,id_funcionalidad)
		values (@idRol,@idFunc);

		set @resultado='OK';
	end
	else 
		set @resultado='Error';

	select @resultado
GO
