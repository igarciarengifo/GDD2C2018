IF OBJECT_ID('LOOPP.SP_GetAllFuncionalidad') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllFuncionalidad
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllFuncionalidad]
AS
	select * from [LOOPP].[Funcionalidades]
GO
