IF OBJECT_ID('LOOPP.SP_GetAllGradosActivos') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllGradosActivos
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllGradosActivos]
AS
BEGIN
	SELECT * FROM [LOOPP].[Grados_Publicacion]
	WHERE [activo]=1
	ORDER BY descripcion
END
GO