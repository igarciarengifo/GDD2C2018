
IF OBJECT_ID('LOOPP.SP_GetAllTiposUbicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllTiposUbicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllTiposUbicacion
AS
	SELECT *
	 from LOOPP.Tipo_Ubicacion
GO