IF OBJECT_ID('LOOPP.SP_GetAllEstadosPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllEstadosPublicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllEstadosPublicacion
AS
	SELECT * from LOOPP.Estados_Publicacion
GO