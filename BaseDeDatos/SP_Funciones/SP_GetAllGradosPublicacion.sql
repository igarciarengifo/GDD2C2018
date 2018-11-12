IF OBJECT_ID('LOOPP.SP_GetAllGradosPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllGradosPublicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllGradosPublicacion
AS
	SELECT * from LOOPP.Grados_Publicacion
GO