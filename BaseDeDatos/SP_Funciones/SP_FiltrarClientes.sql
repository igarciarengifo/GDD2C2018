IF OBJECT_ID('LOOPP.SP_FiltrarClientes') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_FiltrarClientes];
GO

CREATE PROCEDURE [LOOPP].[SP_FiltrarClientes]
	@nombre nvarchar(255),
	@apellido nvarchar(255),
	@email nvarchar(255),
	@nroDoc numeric(18,0)

AS
BEGIN
	SELECT C.id_cliente, C.apellido, C.nombre, C.mail, C.tipo_documento, C.nro_documento, C.fecha_nacimiento, C.direccion_calle, C.direccion_nro, C.direccion_localidad, C.estado, C.baja_logica
	FROM [LOOPP].Clientes as C
	WHERE (C.nombre=@nombre OR @nombre IS NULL OR @nombre = '')
	AND (C.apellido = @apellido OR @apellido IS NULL OR @apellido = '')
	AND (C.mail = @email OR @email IS NULL OR @email = '')
	AND (C.nro_documento = @nroDoc OR @nroDoc IS NULL OR @nroDoc=0)
END
GO
