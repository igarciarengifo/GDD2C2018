IF OBJECT_ID('LOOPP.SP_NuevaUbicac_X_Espectaculo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevaUbicac_X_Espectaculo
GO

/*Inserta ubicacion por espectaculo con el precio segun ubicacion*/
create procedure LOOPP.SP_NuevaUbicac_X_Espectaculo 
						@id_espectaculo int
						,@id_ubicacion int
						,@id_grado_publicacion int
						,@precio_base numeric(18,2)
AS

	insert into [LOOPP].[Ubicac_X_Espectaculo] ([id_espectaculo]
											,[id_ubicacion]
											,[precio])
	values( @id_espectaculo
			  ,@id_ubicacion
			  ,LOOPP.Fn_PrecioXUbicacion(@id_grado_publicacion,@id_ubicacion,@precio_base))

GO