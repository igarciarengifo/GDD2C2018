/*Inserta tabla clientes con datos de la tabla Maestra*/
insert into [LOOPP].[Clientes] (
		[nombre]
      ,[apellido]
      ,[nro_documento]
      ,[fecha_nacimiento]
      ,[mail]
      ,[direccion_calle]
      ,[direccion_nro]
      ,[direccion_piso]
      ,[direccion_depto]
      ,[codigo_postal]
      ,[id_usuario] )
select isnull([Cli_Nombre],'No definido') nombre
	  ,isnull([Cli_Apeliido],'No definido') apellido
	  ,isnull([Cli_Dni],0) dni
      ,[Cli_Fecha_Nac]
      ,isnull([Cli_Mail],'No informado') email
      ,[Cli_Dom_Calle]
      ,[Cli_Nro_Calle]
      ,[Cli_Piso]
      ,[Cli_Depto]
      ,[Cli_Cod_Postal]
	  ,1 id_usuario
from [GD2C2018].[gd_esquema].[Maestra]
where Cli_Dni is not null
group by [Cli_Nombre]
	  ,[Cli_Apeliido]
	  ,[Cli_Dni]
      ,[Cli_Fecha_Nac]
      ,[Cli_Mail]
      ,[Cli_Dom_Calle]
      ,[Cli_Nro_Calle]
      ,[Cli_Piso]
      ,[Cli_Depto]
      ,[Cli_Cod_Postal]



