IF OBJECT_ID('LOOPP.Fn_CalcularPuntos') IS NOT NULL
    DROP FUNCTION LOOPP.Fn_CalcularPuntos
GO

CREATE FUNCTION [LOOPP].[Fn_CalcularPuntos] (@Importe_total numeric (18,0))
RETURNS int
AS BEGIN
		declare @puntos int
	set @puntos = ( @Importe_total /10)
	
    RETURN @puntos
END
GO
