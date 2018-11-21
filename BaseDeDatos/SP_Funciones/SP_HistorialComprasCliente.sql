/*Historial de compras del cliente*/
IF OBJECT_ID('[LOOPP].[SP_HistorialComprasCliente]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_HistorialComprasCliente]
GO

CREATE PROCEDURE [LOOPP].[SP_HistorialComprasCliente] @idUsuario int
AS
	select comp.fecha_compra [Fecha Compra]
		  ,esp.descripcion Espectaculo
		  ,uesp.fecha_espectaculo [Fecha Espectaculo]
		  ,comp.importe_total [Importe Total]
		  ,fp.descripcion [Forma de Pago]
	from [LOOPP].[Compras] comp
	inner join [LOOPP].[Clientes] cli
		on comp.id_cliente=cli.id_cliente and cli.id_usuario=@idUsuario
	inner join [LOOPP].[Formas_Pago_Cliente] fp
		on comp.id_forma_pago_cliente=fp.id_forma_pago_cliente
	inner join [LOOPP].[Localidades_Vendidas] locven
		on locven.id_compra=comp.id_compra
	inner join [LOOPP].Ubicac_X_Espectaculo uesp
		on uesp.id_espectaculo=locven.id_espectaculo and uesp.id_ubicacion=locven.id_ubicacion
	inner join [LOOPP].Espectaculos esp
		on uesp.id_espectaculo=esp.id_espectaculo
	order by comp.fecha_compra
GO