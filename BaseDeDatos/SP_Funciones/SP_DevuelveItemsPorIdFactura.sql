/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4224)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [GD2C2018]
GO
/****** Object:  StoredProcedure [LOOPP].[SP_DevuelveItemsPorIdFactura]    Script Date: 24/11/2018 4:40:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [LOOPP].[SP_DevuelveItemsPorIdFactura] @idFactura int
AS
	select 		  comp.fecha_compra
				  ,tub.descripcion+' - Fila '+ub.fila+' - Asiento '+cast(ub.asiento as varchar(10))+' '+case when ub.sin_numerar=1 then 'Sin numero' else '' end ubicacion
				  ,sum(comp.importe_total) importe_total
				  ,sum(comp.cantidad_compra) cantidad_compra
				  ,SUM([LOOPP].[Fn_CalcularComision](comp.importe_total,esp.id_grado_publicacion)) comision
			from [LOOPP].[Item_Factura] ifact
			left join [LOOPP].[Facturas] fact
				on ifact.nro_factura=fact.nro_factura
			inner join [LOOPP].[Espectaculos] esp
				on fact.id_espectaculo=esp.id_espectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Ubicaciones] ub
				on uesp.id_ubicacion=ub.id_ubicacion
			inner join [LOOPP].[Tipo_Ubicacion] tub
				on ub.id_tipo_ubicacion=tub.id_tipo_ubicacion
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where ifact.nro_factura = @idFactura
			group by comp.fecha_compra
					,tub.descripcion+' - Fila '+ub.fila+' - Asiento '+cast(ub.asiento as varchar(10))+' '+case when ub.sin_numerar=1 then 'Sin numero' else '' end
GO
