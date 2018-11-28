IF OBJECT_ID('LOOPP.SP_FiltrarEmpresas') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_FiltrarEmpresas];
GO

CREATE PROCEDURE [LOOPP].[SP_FiltrarEmpresas]
	@cuit nvarchar(255),
	@razon_soc nvarchar(255),
	@email nvarchar(50)
AS
BEGIN
	SELECT E.razon_social, E.cuit, E.mail, E.telefono, E.direccion_calle, E.direccion_nro, E.ciudad, E.baja_logica
	FROM [LOOPP].Empresas as E
	WHERE (E.cuit = @cuit OR @cuit IS NULL OR @cuit = '')
	AND (E.razon_social = @razon_soc OR @razon_soc IS NULL OR @razon_soc = '')
	AND (E.mail = @email OR @email IS NULL OR @email = '')
	
END
GO
