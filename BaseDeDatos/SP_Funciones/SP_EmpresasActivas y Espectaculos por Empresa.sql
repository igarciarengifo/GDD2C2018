/*SP que devuelve todas las empresas activas*/
IF OBJECT_ID('[LOOPP].[SP_AllEmpresasActivas]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllEmpresasActivas]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEmpresasActivas]
AS
BEGIN
	select [id_empresa],[razon_social]
	from [LOOPP].[Empresas]
	where [baja_logica] = 'False'
	order by right(razon_social,2)

END
GO

/*SP que devuelve todos los espectaculos de una empresa*/
IF OBJECT_ID('[LOOPP].[SP_AllEspectaculosPorIdEmpresa]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdEmpresa]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdEmpresa] @idEmpresa int
AS
BEGIN
	select [id_espectaculo],[descripcion]
	from [LOOPP].[Empresas] emp
	inner join [LOOPP].[Usuarios] usu
	on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
	inner join [LOOPP].[Espectaculos] esp
	on usu.id_usuario=esp.id_usuario_responsable
	group by [id_espectaculo],[descripcion]

END
GO