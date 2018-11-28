IF OBJECT_ID('LOOPP.SP_InhabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarRol
GO

create procedure LOOPP.SP_InhabilitarRol (@id_user int)
as
begin

	declare @result bit
	select @result=case when estado='Inconsistente' then 1 else 0 end
	from LOOPP.Clientes	
	where id_usuario=@id_user
	if @result is null 
	begin
		set @result=0
	end
	select @result
end