USE [GD2C2018]
GO
IF OBJECT_ID('LOOPP.FN_RemoveNonAlphaCharacters') IS NOT NULL
    DROP FUNCTION LOOPP.FN_RemoveNonAlphaCharacters
GO
Create Function [LOOPP].[FN_RemoveNonAlphaCharacters](@Temp VarChar(255))
Returns VarChar(255)
AS
Begin

    Declare @KeepValues as varchar(255)
    Set @KeepValues = '%[^a-z0-9]%'
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return Lower( replace(@Temp, 'nº', ''))
End