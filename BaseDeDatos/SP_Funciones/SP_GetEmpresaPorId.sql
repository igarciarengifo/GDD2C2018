USE [GD2C2018]
GO
IF OBJECT_ID('LOOPP.SP_GetEmpresaPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEmpresaPorId
GO
CREATE PROCEDURE [LOOPP].[SP_GetEmpresaPorId]
	
	@idEmpresa int
AS
BEGIN
	SELECT * FROM Empresas WHERE id_empresa=@idEmpresa
END
