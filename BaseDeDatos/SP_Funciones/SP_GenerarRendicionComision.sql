/*Retorna valor de comision por total de compra*/
IF OBJECT_ID('[LOOPP].[Fn_CalcularComision]') IS NOT NULL
    DROP Function [LOOPP].[Fn_CalcularComision]
GO
CREATE FUNCTION [LOOPP].[Fn_CalcularComision] (@Importe_total numeric (18,0), @idPrioridad int)
RETURNS numeric(18,0)
AS 
	BEGIN
		declare @comision numeric(18,0)
		
		select @comision=(@Importe_total*comision)
		from [LOOPP].[Grados_Publicacion]
		where id_grado_publicacion=@idPrioridad
	
		RETURN @comision
	END
GO

/*SP que devuelve consulta con compras segun id seleccionadas en la APP*/
IF OBJECT_ID('[LOOPP].[SP_RetonaComprasSegunIdList]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_RetonaComprasSegunIdList]
GO
CREATE PROCEDURE [LOOPP].[SP_RetonaComprasSegunIdList] @idList varchar(100)
AS
BEGIN

	DECLARE @SQL varchar(max)

	SET @SQL = 
			'select id_compra,fecha_compra,importe_total,cantidad_compra,facturado
			from [LOOPP].[Compras]
			where id_compra IN (' + @idList + ')'

	EXEC(@SQL)	
END
GO

/*Generar rendicion de comisiones*/
IF OBJECT_ID('[LOOPP].[SP_GenerarRendicionComision]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GenerarRendicionComision]
GO
CREATE PROCEDURE [LOOPP].[SP_GenerarRendicionComision] @idEmpresa int, @idEspectaculo int, @idList varchar(100)
AS
	BEGIN TRANSACTION [T]

	BEGIN TRY

	/*Genero tabla temporal con los registros obtenidos*/
	CREATE TABLE #Temp_Compra (	[id_compra] [int] NOT NULL,
								[fecha_compra] [datetime] NOT NULL,
								[importe_total] [numeric](18, 0) NOT NULL,
								[cantidad_compra] [numeric](18, 0) NOT NULL,
								[facturado] [bit] NOT NULL)

	insert into #Temp_Compra ([id_compra],[fecha_compra],[importe_total],[cantidad_compra],[facturado]) 
	exec [LOOPP].[SP_RetonaComprasSegunIdList] @idList;
		
		select esp.id_espectaculo
			,emp.id_empresa
			,comp.id_compra
			,esp.descripcion
			,comp.fecha_compra
			,comp.importe_total
			,comp.cantidad_compra
			,[LOOPP].[Fn_CalcularComision](comp.importe_total,esp.id_grado_publicacion) comision
		into #Temp_Rendicion
		from [LOOPP].[Empresas] emp
		left join [LOOPP].[Usuarios] usu
			on emp.id_usuario=usu.id_usuario
		inner join [LOOPP].[Espectaculos] esp
			on usu.id_usuario=esp.id_usuario_responsable 
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		inner join [LOOPP].[Localidades_Vendidas] lv
			on uesp.id_espectaculo=lv.id_espectaculo
		inner join #Temp_Compra comp
			on lv.id_compra=comp.id_compra
		where comp.facturado = 'False'
		and emp.id_empresa=@idEmpresa
		and esp.id_espectaculo=@idEspectaculo
		group by esp.id_espectaculo,emp.id_empresa,comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total,comp.cantidad_compra
		,[LOOPP].[Fn_CalcularComision](comp.importe_total,esp.id_grado_publicacion)
		order by comp.fecha_compra asc

		declare @newId int;
		select @newId=MAX([nro_factura])+1 from [LOOPP].[Facturas];

		insert into [LOOPP].[Facturas]([nro_factura],[id_empresa],[id_espectaculo],[fecha_factura],[total_factura],[total_comision])
		select @newId,id_empresa,id_espectaculo,GETDATE(),SUM(importe_total),SUM(comision)
		from #Temp_Rendicion
		group by id_empresa,id_espectaculo
		
		insert into [LOOPP].[Item_Factura]([nro_factura],[monto_compra],[monto_comision],[cantidad],[descripcion])
		select @newId,importe_total,comision,cantidad_compra,'Comision por compra'
		from #Temp_Rendicion

		update LOOPP.Compras
		set facturado = 'True'
		where id_compra in (select id_compra from #Temp_Compra)
			
	COMMIT TRANSACTION [T]

	select ifa.*
	from [LOOPP].[Item_Factura] ifa
	inner join [LOOPP].[Facturas] fa
	on ifa.nro_factura=fa.nro_factura
	where fa.nro_factura=@newId;

	drop table #Temp_Compra;
	drop table #Temp_Rendicion;

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  print 'No se pudo realizar la facturacion - Error: ' + ERROR_MESSAGE();

	END CATCH;
GO