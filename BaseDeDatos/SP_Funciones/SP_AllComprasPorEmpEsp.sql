IF OBJECT_ID('[LOOPP].[SP_AllComprasPorEmpresa]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllComprasPorEmpresa]
GO
CREATE PROCEDURE [LOOPP].[SP_AllComprasPorEmpresa] @idEmpresa int,@idEspectaculo int
AS
BEGIN
	if (@idEspectaculo is not null)
		begin
			select comp.id_compra
				  ,esp.descripcion Espectaculo
				  ,comp.fecha_compra [Fecha Compra]
				  ,comp.importe_total [Importe Total]
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable and esp.id_espectaculo=@idEspectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where comp.facturado='False'
			group by comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total
			order by comp.fecha_compra asc
		end

	else
		begin
			select comp.id_compra
				  ,esp.descripcion Espectaculo
				  ,comp.fecha_compra [Fecha Compra]
				  ,comp.importe_total [Importe Total]
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable --and esp.id_espectaculo=@idEspectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where comp.facturado='False'
			group by comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total
			order by comp.fecha_compra asc
		end
END
GO