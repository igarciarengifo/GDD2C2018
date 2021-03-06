USE GD2C2018
GO

/*Creacion de Estados_Publicacion*/

INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Borrador');--id=1
INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Publicada');--id=2
INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Pausada');--id=3
INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Finalizada');--id=4
GO
-------------------------------------------------------------------------------

/*Creacion de Tipo_Ubicacion*/

INSERT INTO LOOPP.Tipo_Ubicacion ( 
	id_tipo_ubicacion, 
	descripcion, 
	porcentual )
SELECT 
	DISTINCT Ubicacion_Tipo_Codigo, 
	Ubicacion_Tipo_Descripcion,
	CASE	WHEN Ubicacion_Tipo_Descripcion = 'Platea Alta' THEN 1.35
			WHEN Ubicacion_Tipo_Descripcion = 'Platea Baja' THEN 1.5
			WHEN Ubicacion_Tipo_Descripcion = 'Vip' THEN 1.8
			WHEN Ubicacion_Tipo_Descripcion = 'Campo' THEN 1.2
			WHEN Ubicacion_Tipo_Descripcion = 'Campo Vip' THEN 1.6
			WHEN Ubicacion_Tipo_Descripcion = 'PullMan' THEN 1.25
			WHEN Ubicacion_Tipo_Descripcion = 'Super PullMan' THEN 1.55
			WHEN Ubicacion_Tipo_Descripcion = 'Cabecera' THEN 1
	END AS porcentual 
FROM gd_esquema.Maestra
ORDER BY Ubicacion_Tipo_Codigo
GO
-------------------------------------------------------------------------------
/*Creacion de formas de pago disponibles*/

INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Efectivo', null);
INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Tarjeta Credito', 'VISA');
INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Tarjeta Credito', 'MASTERCARD');
INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Tarjeta Credito', 'AMERICAN EXPRESS');
INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Tarjeta Debito', 'VISA');
INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Tarjeta Debito', 'MASTERCARD');
INSERT INTO LOOPP.Formas_Pago (descripcion, marca) VALUES ('Tarjeta Debito', 'AMERICAN EXPRESS');

-------------------------------------------------------------------------------

/*Creacion de Rubros*/

INSERT INTO LOOPP.Rubros (descripcion) VALUES ('No definido');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Musical');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Obra Teatral');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Humoristico');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Audio Visual');
-------------------------------------------------------------------------------

/*Grados de Publicacion*/
INSERT INTO LOOPP.Grados_Publicacion (comision,descripcion) VALUES (0.30,'Alta');
INSERT INTO LOOPP.Grados_Publicacion (comision, descripcion) VALUES (0.25, 'Media');
INSERT INTO LOOPP.Grados_Publicacion (comision, descripcion) VALUES (0.10, 'Baja');
-------------------------------------------------------------------------------

/*Creacion de Roles*/

INSERT INTO [LOOPP].[Roles]([nombre]) VALUES ('Administrativo');
INSERT INTO [LOOPP].[Roles]([nombre]) VALUES ('Cliente');
INSERT INTO [LOOPP].[Roles]([nombre]) VALUES ('Empresa');
-------------------------------------------------------------------------------

/*Creacion de usuario Admin*/

INSERT INTO [LOOPP].[Usuarios] (username,password)
--user :admin pass: w23e
VALUES ('admin', '52d77462b24987175c8d7dab901a5967e927ffc8d0b6e4a234e07a4aec5e3724');
-------------------------------------------------------------------------------

/*Creacion de Rol_X_Usuario para el admin*/

INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) VALUES (1,1);
INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) VALUES (1,2);
INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) VALUES (1,3);
-------------------------------------------------------------------------------

/*Creacion de funcionalidades*/

INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('ABM Rol');  --1
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('ABM Clientes'); --2
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('ABM Empresas'); --3
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Comprar Entrada'); --4
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Modificar Compra'); --5
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Publicar Espectaculo'); --6
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Modificar Publicacion'); --7
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Facturar rendiciones'); --8
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Historial Cliente');  --9
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Canjear Puntos'); --10 
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Listado Estadistico');  --11
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('ABM Grado Publicacion');  --12
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('ABM de Rubros');  --13
-------------------------------------------------------------------------------

/*Creacion de Funcionalidad_X_Rol*/

INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,1);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,2);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,3);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,8);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,11);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,12);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,13);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,4);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,5);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,9);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,10);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (3,6);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (3,7);
-------------------------------------------------------------------------------

/*Creacion de ubicaciones*/

INSERT INTO LOOPP.Ubicaciones (
	fila,
	asiento, 
	sin_numerar, 
	id_tipo_ubicacion)
SELECT 
	Ubicacion_Fila, 
	Ubicacion_Asiento, 
	Ubicacion_Sin_numerar, 
	Ubicacion_Tipo_Codigo
FROM gd_esquema.Maestra
GROUP BY Ubicacion_Fila, Ubicacion_Asiento, Ubicacion_Sin_numerar, Ubicacion_Tipo_Codigo
ORDER BY Ubicacion_Tipo_Codigo, Ubicacion_Fila, Ubicacion_Asiento
-------------------------------------------------------------------------------

/*Creacion catalogo de Canje*/

INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES (10, '2 Entradas gratis', 1000);
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, '1 Entrada gratis', 800);
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, 'Una remera del espectaculo', 500);
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, 'Una consumici�n gratis', 300);
-------------------------------------------------------------------------------
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

    Return Lower( replace(@Temp, 'n�', ''))
End
GO
-------------------------------------------------------------------------------

/*Migracion de clientes*/

/*Se agrupa clientes de la tabla Maestra y se inserta en una tabla Temporal*/
select [Cli_Nombre] nombre
	  ,[Cli_Apeliido] apellido
	  ,[Cli_Dni] dni
      ,[Cli_Fecha_Nac]
      ,[Cli_Mail] email
      ,[Cli_Dom_Calle]
      ,[Cli_Nro_Calle]
      ,[Cli_Piso]
      ,[Cli_Depto]
      ,[Cli_Cod_Postal]
into #Temp_Clientes
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
      ,[Cli_Cod_Postal];
/*Se busca si existe incosistencia en los datos mediante otra tabla Temporal*/
SELECT  [Nombre]
		 ,[Apellido]
		 ,[Dni]
		 ,[Cli_Fecha_Nac]
		 ,[Email]
		 ,[Cli_Dom_Calle]
		 ,[Cli_Nro_Calle]
		 ,[Cli_Piso]
		 ,[Cli_Depto]
		 ,[Cli_Cod_Postal]
		 ,row_number() OVER(PARTITION BY [Dni] ORDER BY Email) AS cantDni
		 ,row_number() OVER(PARTITION BY [Email] ORDER BY Email) AS cantEmail
INTO #Temp_Cli_Incons
FROM #Temp_Clientes
GROUP BY	 [Nombre]
			,[Apellido]
			,[Dni]
			,[Cli_Fecha_Nac]
			,[Email]
			,[Cli_Dom_Calle]
			,[Cli_Nro_Calle]
			,[Cli_Piso]
			,[Cli_Depto]
			,[Cli_Cod_Postal];

DROP TABLE #Temp_Clientes;

/*Se inserta tabla usuarios antes de insertar el cliente, ya que cliente tiene un FK a la tabla usuarios*/
DECLARE @newMail nvarchar(255)
insert into [LOOPP].[Usuarios] (
		[username]
		,[password]
		,[primerLoginAuto])
select LOOPP.FN_RemoveNonAlphaCharacters(left(email,charindex('@',email,1)-1)) userName
		,'4f37c061f1854f9682f543fecb5ee9d652c803235970202de97c6e40c8361766' pass
		,'True'
from #Temp_Cli_Incons
where cantDni=1 and cantEmail=1

INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
SELECT id_usuario,2
FROM [LOOPP].[Usuarios]
where id_usuario not in (select id_usuario from [LOOPP].[Rol_X_Usuario])
/*Se inserta tabla clientes con los datos de clientes que sean unicos*/
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
select [Nombre]
		 ,[Apellido]
		 ,[Dni]
		 ,[Cli_Fecha_Nac]
		 ,[Email]
		 ,[Cli_Dom_Calle]
		 ,[Cli_Nro_Calle]
		 ,[Cli_Piso]
		 ,[Cli_Depto]
		 ,[Cli_Cod_Postal]
		 ,usu.id_usuario
from #Temp_Cli_Incons tmp
inner join [LOOPP].[Usuarios] usu
on LOOPP.FN_RemoveNonAlphaCharacters(left(email,charindex('@',email,1)-1))=usu.username
where cantDni=1 and cantEmail=1
order by dni

/*Se inserta tabla usuarios antes de insertar el cliente, ya que cliente tiene un FK a la tabla usuarios*/
insert into [LOOPP].[Usuarios] (
		[username]
		,[password]
		,[habilitado]
		,[primerLoginAuto])
select LOOPP.FN_RemoveNonAlphaCharacters(left(email,charindex('@',email,1)-1))+'_duplicado' userName
		,'4f37c061f1854f9682f543fecb5ee9d652c803235970202de97c6e40c8361766' pass
		,'True'
		,'True'
from #Temp_Cli_Incons
where cantDni=1 and cantEmail>1

INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
SELECT id_usuario,2
FROM [LOOPP].[Usuarios]
where id_usuario not in (select id_usuario from [LOOPP].[Rol_X_Usuario])

/*Se inserta tabla clientes con los datos de clientes que poseen datos incosistentes
  Como por ejemplo 2 emials iguales para clientes con distinto dni*/
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
	  ,[estado]
	  ,[baja_logica]
      ,[id_usuario] )
select [Nombre]
		 ,[Apellido]
		 ,[Dni]
		 ,[Cli_Fecha_Nac]
		 ,[Email]
		 ,[Cli_Dom_Calle]
		 ,[Cli_Nro_Calle]
		 ,[Cli_Piso]
		 ,[Cli_Depto]
		 ,[Cli_Cod_Postal]
		 ,'Inconsistente' estado
		 ,'False'
		 ,usu.id_usuario
from #Temp_Cli_Incons tmp
inner join [LOOPP].[Usuarios] usu
on LOOPP.FN_RemoveNonAlphaCharacters(left(email,charindex('@',email,1)-1))+'_duplicado'=usu.username
where cantDni=1 and cantEmail>1
order by dni

DROP TABLE #Temp_Cli_Incons;
-------------------------------------------------------------------------------

/*Migracion de Empresas*/

SELECT 
	Espec_Empresa_Razon_Social,
	Espec_Empresa_Cuit, 
	Espec_Empresa_Fecha_Creacion,
	Espec_Empresa_Mail email,
	Espec_Empresa_Dom_Calle,
	Espec_Empresa_Nro_Calle,
	Espec_Empresa_Piso,
	Espec_Empresa_Depto,
	Espec_Empresa_Cod_Postal
into #Temp_Empresas
FROM [GD2C2018].[gd_esquema].[Maestra]
where Espec_Empresa_Cuit  is not null
group by 
	Espec_Empresa_Razon_Social,
	Espec_Empresa_Cuit, 
	Espec_Empresa_Fecha_Creacion,
	Espec_Empresa_Mail,
	Espec_Empresa_Dom_Calle,
	Espec_Empresa_Nro_Calle,
	Espec_Empresa_Piso,
	Espec_Empresa_Depto,
	Espec_Empresa_Cod_Postal
;

/*Se inserta tabla usuarios antes de insertar la empresa, ya que empresa tiene un FK a la tabla usuarios*/

insert into [LOOPP].[Usuarios] (
		[username]
		,[password]
		,[primerLoginAuto])
select LOOPP.FN_RemoveNonAlphaCharacters(left(email,charindex('@',email,1)-1)) userName
		,'4f37c061f1854f9682f543fecb5ee9d652c803235970202de97c6e40c8361766' pass
		,'True'
from #Temp_Empresas

INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
SELECT id_usuario,3
FROM [LOOPP].[Usuarios]
where id_usuario not in (select id_usuario from [LOOPP].[Rol_X_Usuario])

/*Se inserta tabla empresas */

insert into [LOOPP].[Empresas] (
	 razon_social,
	 cuit,
	 fecha_creacion,
	 mail,
	 direccion_calle,
	 direccion_nro,
	 direccion_piso,
	 direccion_depto,
	 cod_postal,
	 id_usuario )
select	Espec_Empresa_Razon_Social,
		Espec_Empresa_Cuit, 
		Espec_Empresa_Fecha_Creacion,
		 email,
		Espec_Empresa_Dom_Calle,
		Espec_Empresa_Nro_Calle,
		Espec_Empresa_Piso,
		Espec_Empresa_Depto,
		Espec_Empresa_Cod_Postal,
		usu.id_usuario 
FROM #Temp_Empresas
inner join [LOOPP].[Usuarios] usu
on LOOPP.FN_RemoveNonAlphaCharacters(left(email,charindex('@',email,1)-1))=usu.username
order by Espec_Empresa_Cuit

DROP TABLE #Temp_Empresas;
-------------------------------------------------------------------------------

/*Migracion Forma de pago clientes*/

insert into [LOOPP].[Formas_Pago_Cliente] (
	id_forma_pago,
	id_cliente,
	nro_tarjeta)
select 1,clie.id_cliente, null
FROM [gd_esquema].[Maestra] m
inner join [LOOPP].[Clientes] clie on clie.nro_documento = m.Cli_Dni
where Forma_Pago_Desc is not null
group by clie.id_cliente

-------------------------------------------------------------------------------

/*Migracion de Espectaculos*/

/*Se genera una tabla temporal con los datos unicos sin repetidos*/
SELECT [Espectaculo_Cod] id
      ,[Espectaculo_Descripcion] descripcion
      ,[Espectaculo_Fecha] espec_fecha
      ,[Espectaculo_Fecha_Venc] venc_publicacion
      ,[Espectaculo_Rubro_Descripcion] rubro
      ,[Espectaculo_Estado] estado
	  ,LOOPP.FN_RemoveNonAlphaCharacters(left(Espec_Empresa_Mail,charindex('@',Espec_Empresa_Mail,1)-1)) usuario
into #TEMP_Espectaculo
  FROM [GD2C2018].[gd_esquema].[Maestra]
  group by [Espectaculo_Cod]
      ,[Espectaculo_Descripcion]
      ,[Espectaculo_Fecha]
      ,[Espectaculo_Fecha_Venc]
      ,[Espectaculo_Rubro_Descripcion]
      ,[Espectaculo_Estado]
	  ,LOOPP.FN_RemoveNonAlphaCharacters(left(Espec_Empresa_Mail,charindex('@',Espec_Empresa_Mail,1)-1))
  order by [Espectaculo_Cod]
  --7.803 rows

/*Se inserta tabla Estapectaculos*/

	insert into [LOOPP].[Espectaculos](
			 [id_espectaculo]
			,[id_usuario_responsable]
			,[id_rubro]
			,[fecha_publicacion]
			,[descripcion]
			,[id_estado_publicacion]
			,[id_grado_publicacion]
			,[fecha_espectaculo]
			,[fecha_venc_espectaculo]
			,[hora_espectaculo]
			)
	select t.id
			,u.id_usuario
			,1--rubro 'No Definido'
			,t.venc_publicacion
			,t.descripcion
			,e.id_estado_publicacion
			,3--grado de publicacion 'Baja'
			,cast(espec_fecha as date) 
			,cast(venc_publicacion as date) 
			,'00:00:00'
	from #TEMP_Espectaculo t
	inner join [LOOPP].[Usuarios] u
	on t.usuario=u.username
	inner join [LOOPP].[Estados_Publicacion] e
	on t.estado=e.descripcion

	Drop table #TEMP_Espectaculo;
-------------------------------------------------------------------------------

/*Migracion de Ubicacion por Espectaculo*/

/*Se genera una tabla temporal con los datos unicos sin repetidos*/
	SELECT [Espectaculo_Cod]
		  ,[Espectaculo_Fecha]
		  ,[Espectaculo_Fecha_Venc]
		  ,[Ubicacion_Fila]
		  ,[Ubicacion_Asiento]
		  ,[Ubicacion_Sin_numerar]
		  ,[Ubicacion_Precio]
		  ,[Ubicacion_Tipo_Codigo]
		  ,[Ubicacion_Tipo_Descripcion]
	into #Temp_Ubic_Espec
	FROM [GD2C2018].[gd_esquema].[Maestra]
	group by [Espectaculo_Cod]
		  ,[Espectaculo_Fecha]
		  ,[Espectaculo_Fecha_Venc]
		  ,[Ubicacion_Fila]
		  ,[Ubicacion_Asiento]
		  ,[Ubicacion_Sin_numerar]
		  ,[Ubicacion_Precio]
		  ,[Ubicacion_Tipo_Codigo]
		  ,[Ubicacion_Tipo_Descripcion]
	order by [Espectaculo_Cod]
	--238.143

	/*Inserta las ubicaciones ya reservadas*/
	insert into [LOOPP].[Ubicac_X_Espectaculo] (
				[id_espectaculo]
				,[id_ubicacion]
				,[precio]
				,disponible)
	select e.id_espectaculo
		  ,u.id_ubicacion
		  ,t.Ubicacion_Precio
		  ,'False' disponible
	from #Temp_Ubic_Espec t
	inner join [LOOPP].[Espectaculos] e
		on t.Espectaculo_Cod=e.id_espectaculo
	inner join [LOOPP].[Ubicaciones] u
		on t.Ubicacion_Fila=u.fila and t.Ubicacion_Asiento=u.asiento
	inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion and t.Ubicacion_Tipo_Descripcion=tu.descripcion
	order by e.id_espectaculo,u.id_ubicacion;

	/*Inserta ubicaciones disponibles por espectaculo*/
	insert into [LOOPP].[Ubicac_X_Espectaculo] (
				[id_espectaculo]
				,[id_ubicacion]
				,[precio])
	select e.id_espectaculo
		  ,u.id_ubicacion
		  ,t.Ubicacion_Precio
	from #Temp_Ubic_Espec t
	inner join [LOOPP].[Espectaculos] e
		on t.Espectaculo_Cod=e.id_espectaculo
	right join [LOOPP].[Ubicaciones] u
		on t.Ubicacion_Fila=u.fila and t.Ubicacion_Asiento=u.asiento
	where not exists (select 1 from [LOOPP].[Ubicac_X_Espectaculo] uxe 
					  where uxe.id_espectaculo=e.id_espectaculo and uxe.id_ubicacion=u.id_ubicacion)
	order by e.id_espectaculo,u.id_ubicacion;

	Drop table #Temp_Ubic_Espec;
-------------------------------------------------------------------------------

/*Migracion de Facturas*/

/*Se genera una tabla temporal con los datos unicos sin repetidos*/
SELECT [Espec_Empresa_Cuit]
      ,[Espectaculo_Cod]
	  ,[Espectaculo_Fecha]
      ,[Factura_Nro]
      ,[Factura_Fecha]
      ,[Factura_Total] total_comision
	  ,SUM([Ubicacion_Precio]) total_facturado
into #Temp_Factura
FROM [GD2C2018].[gd_esquema].[Maestra]
where [Factura_Nro] is not null
group by [Espec_Empresa_Cuit]
      ,[Espectaculo_Cod]
	  ,[Espectaculo_Fecha]
      ,[Factura_Nro]
      ,[Factura_Fecha]
      ,[Factura_Total]
order by [Espec_Empresa_Cuit]
      ,[Espectaculo_Cod]
	  ,[Factura_Nro]
--7.664 rows

insert into [LOOPP].[Facturas](
			[nro_factura]
		   ,[fecha_factura]
		   ,[total_factura]
		   ,[total_comision]
		   ,[id_empresa]
		   ,[id_espectaculo])
select t.Factura_Nro
	  ,t.Factura_Fecha
	  ,t.total_facturado
	  ,t.total_comision
	  ,em.id_empresa
	  ,es.id_espectaculo
from #Temp_Factura t
inner join [LOOPP].[Empresas] em
	on t.Espec_Empresa_Cuit=em.cuit
inner join [LOOPP].[Espectaculos] es
	on t.Espectaculo_Cod=es.id_espectaculo
order by t.Factura_Nro

Drop table #Temp_Factura;
-------------------------------------------------------------------------------

/*Migracion de Items Factura*/

insert into [LOOPP].[Item_Factura](
			[nro_factura]
			,[monto_compra]
			,[monto_comision]
			,[cantidad]
			,[descripcion])
SELECT [Factura_Nro]
	  ,[Ubicacion_Precio]
      ,[Item_Factura_Monto]
      ,[Item_Factura_Cantidad]
      ,[Item_Factura_Descripcion]
FROM [GD2C2018].[gd_esquema].[Maestra]
where [Factura_Nro] is not null
order by [Factura_Nro]
--94.142 rows
-------------------------------------------------------------------------------

/*Migracion de Compras*/
INSERT INTO [LOOPP].[Compras] (
	fecha_compra,
	importe_total,
	[cantidad_compra],
	puntos,
	id_cliente,
	id_forma_pago_cliente,
	facturado
)
SELECT
	[Compra_Fecha],
	(Ubicacion_Precio),
	[Compra_Cantidad],
	LOOPP.Fn_CalcularPuntos(Ubicacion_Precio),
	clie.id_cliente,
	f.id_forma_pago_cliente,
	'True'
FROM [gd_esquema].[Maestra]
inner join [LOOPP].[Clientes] clie 
	on clie.nro_documento = Cli_Dni
left join [LOOPP].[Formas_Pago_Cliente] f 
	on f.id_cliente = clie.id_cliente
inner join LOOPP.Ubicaciones u 
	on u.fila=Ubicacion_Fila and u.asiento= Ubicacion_Asiento
inner join LOOPP.Tipo_Ubicacion tu 
	on tu.id_tipo_ubicacion = u.id_tipo_ubicacion and tu.descripcion = Ubicacion_Tipo_Descripcion
where Compra_Fecha is not null
group by [Compra_Fecha], Ubicacion_Precio, porcentual ,[Compra_Cantidad], clie.id_cliente, f.id_forma_pago_cliente, Ubicacion_Asiento, Ubicacion_Fila
order by Compra_Fecha;

---------------------------------------------------------------------------------

/*Migracion Localidades Vendidas*/

/*Se genera una tabla temporal con los datos unicos sin repetidos*/
	SELECT [Espectaculo_Cod]
		  ,[Ubicacion_Fila]
		  ,[Ubicacion_Asiento]
		  ,[Ubicacion_Sin_numerar]
		  ,[Cli_Dni]
		  ,[Compra_Fecha]

	into #Temp_Ubic_Espec_compra
	FROM [GD2C2018].[gd_esquema].[Maestra]
	group by  [Espectaculo_Cod]
		  ,[Ubicacion_Fila]
		  ,[Ubicacion_Asiento]
		  ,[Ubicacion_Sin_numerar]
		  ,[Cli_Dni]
		  ,[Compra_Fecha]
	order by [Espectaculo_Cod]

	--332.285

insert into [LOOPP].[Localidades_Vendidas] (
			[id_espectaculo]
			,[id_compra]
			,[id_ubicacion] )
select 
			uxe.id_espectaculo,
			c.id_compra,
			uxe.id_ubicacion
	FROM #Temp_Ubic_Espec_compra t
inner join [LOOPP].[Ubicaciones] u 
	on t.Ubicacion_Fila=u.fila and t.Ubicacion_Asiento=u.asiento
inner join LOOPP.Ubicac_X_Espectaculo uxe 
	on uxe.id_espectaculo = t.Espectaculo_Cod and uxe.id_ubicacion = u.id_ubicacion
inner join [LOOPP].[Clientes] clie 
	on clie.nro_documento = t.Cli_Dni
inner join [LOOPP].[Compras]c 
	on  c.id_cliente = clie.id_cliente  and c.fecha_compra = t.Compra_Fecha
order by c.id_compra 

--130.362

drop table #Temp_Ubic_Espec_compra

