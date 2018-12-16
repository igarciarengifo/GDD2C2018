IF OBJECT_ID('LOOPP.SP_GetAllUbicaciones') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllUbicaciones
GO
CREATE PROCEDURE LOOPP.SP_GetAllUbicaciones
AS
	SELECT id_ubicacion, T_U.descripcion + '-' +fila+LTRIM(RTRIM(STR(asiento))) as descripcion, fila, asiento, sin_numerar, u.id_tipo_ubicacion
	 from LOOPP.Ubicaciones U
	 INNER JOIN Tipo_Ubicacion T_U on T_U.id_tipo_ubicacion=U.id_tipo_ubicacion
GO