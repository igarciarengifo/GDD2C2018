IF OBJECT_ID('LOOPP.SP_GetClientePorId') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetClientePorId];
GO
CREATE PROCEDURE [LOOPP].[SP_GetClientePorId]
	
	@idCliente int
AS
BEGIN
	SELECT * FROM Clientes WHERE id_cliente=@idCliente
END

