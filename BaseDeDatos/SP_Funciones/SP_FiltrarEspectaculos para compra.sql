/*SP que devuelve consulta con compras segun id seleccionadas en la APP*/
IF OBJECT_ID('[LOOPP].[SP_RetornaCategoriasSegunIdList]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_RetornaCategoriasSegunIdList]
GO
CREATE PROCEDURE [LOOPP].[SP_RetornaCategoriasSegunIdList] @idList varchar(100)
AS
BEGIN

	DECLARE @SQL varchar(max)

	SET @SQL = 
			'select *
			from [LOOPP].[Rubros]
			where [id_rubro] IN (' + @idList + ')'

	EXEC(@SQL)	
END
GO

/*Devuelve espectaculos para realizar compra*/
IF OBJECT_ID('[LOOPP].[SP_FiltrarEspectaculos]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_FiltrarEspectaculos]
GO
CREATE PROCEDURE [LOOPP].[SP_FiltrarEspectaculos] @idEspectaculo int, @idList varchar(100), @desde date, @hasta date
AS
BEGIN
	
	if (@idEspectaculo is not null)
	begin

		select esp.id_espectaculo,esp.descripcion,uesp.fecha_espectaculo,uesp.hora_espectaculo
		from [LOOPP].[Espectaculos] esp
		inner join [LOOPP].[Estados_Publicacion] estado
			on esp.id_estado_publicacion=estado.id_estado_publicacion and estado.descripcion='Publicada'
		inner join [LOOPP].[Grados_Publicacion] grado
			on esp.id_grado_publicacion=grado.id_grado_publicacion
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		where esp.id_espectaculo=@idEspectaculo 
		and uesp.fecha_espectaculo between @desde and @hasta
		group by esp.id_espectaculo,esp.descripcion,grado.id_grado_publicacion,uesp.fecha_espectaculo,uesp.hora_espectaculo
		order by grado.id_grado_publicacion
	end

	if (@idEspectaculo is null and @idList is not null)
	begin

		/*Genero tabla temporal con los registros obtenidos*/
		CREATE TABLE #Temp_Rubros (	[id_rubro] int NOT NULL,
									[descripcion] varchar(20) NOT NULL)

		insert into #Temp_Rubros ([id_rubro],[descripcion]) 
		exec [LOOPP].[SP_RetornaCategoriasSegunIdList] @idList;

		select esp.id_espectaculo,esp.descripcion,uesp.fecha_espectaculo,uesp.hora_espectaculo
		from [LOOPP].[Espectaculos] esp
		inner join #Temp_Rubros rubros
		on esp.id_rubro=rubros.id_rubro
		inner join [LOOPP].[Estados_Publicacion] estado
			on esp.id_estado_publicacion=estado.id_estado_publicacion and estado.descripcion='Publicada'
		inner join [LOOPP].[Grados_Publicacion] grado
			on esp.id_grado_publicacion=grado.id_grado_publicacion
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		where uesp.fecha_espectaculo between @desde and @hasta
		group by esp.id_espectaculo,esp.descripcion,grado.id_grado_publicacion,uesp.fecha_espectaculo,uesp.hora_espectaculo
		order by grado.id_grado_publicacion
	end
END
GO