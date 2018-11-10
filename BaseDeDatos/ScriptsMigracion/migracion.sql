USE GD2C2018
GO

/*Creacion de Estados_Publicacion*/

INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Borrador');
INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Publicada');
INSERT INTO LOOPP.Estados_Publicacion (descripcion)
VALUES ('Finalizada');
GO
-------------------------------------------------------------------------------

/*Creacion de Tipo_Ubicacion*/

INSERT INTO LOOPP.Tipo_Ubicacion ( 
	id_tipo_ubicacion, 
	descripcion, 
	porcentual)
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

/*Creacion de Rubros*/

INSERT INTO LOOPP.Rubros (descripcion) VALUES ('No definido');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Musical');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Obra Teatral');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Humoristico');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Audio Visual');
-------------------------------------------------------------------------------

/*Grados de Publicacion*/
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision,descripcion) VALUES (0,0.00,'No Definido');
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision,descripcion) VALUES (1,0.30,'Alta');
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision, descripcion) VALUES (2, 0.25, 'Media');
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision, descripcion) VALUES (3, 0.10, 'Baja');
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
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Historal Cliente');  --9
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

INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES (10, 'Entrada gratis', 1000);
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, 'Descuento %30 en entradas', 800);
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, 'Descuento %20 en entradas', 500);
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, 'Descuento %10 en entradas', 300);
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
insert into [LOOPP].[Usuarios] (
		[username]
		,[password])
select left(email,charindex('@',email,1)-1) userName
		,'1234' pass
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
on left(email,charindex('@',email,1)-1)=usu.username
where cantDni=1 and cantEmail=1
order by dni

/*Se inserta tabla usuarios antes de insertar el cliente, ya que cliente tiene un FK a la tabla usuarios*/
insert into [LOOPP].[Usuarios] (
		[username]
		,[password]
		,[habilitado])
select left(email,charindex('@',email,1)-1)+'_duplicado' userName
		,'1234' pass
		,'False'
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
		 ,usu.id_usuario
from #Temp_Cli_Incons tmp
inner join [LOOPP].[Usuarios] usu
on left(email,charindex('@',email,1)-1)+'_duplicado'=usu.username
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
		,[password])
select left(email,charindex('@',email,1)-1) userName
		,'1234' pass
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
on left(email,charindex('@',email,1)-1)=usu.username
order by Espec_Empresa_Cuit

DROP TABLE #Temp_Empresas;
-------------------------------------------------------------------------------

/*Migracion Forma de pago clientes*/

insert into [LOOPP].[Formas_Pago_Cliente] (
	descripcion,
	id_cliente
	 )
select	
		[Forma_Pago_Desc],
		clie.id_cliente 
FROM [gd_esquema].[Maestra] m
inner join [LOOPP].[Clientes] clie on clie.nro_documento = m.Cli_Dni
where Forma_Pago_Desc is not null
group by Forma_Pago_Desc, clie.id_cliente
-------------------------------------------------------------------------------

/*Migracion de Espectaculos*/

/*Se genera una tabla temporal con los datos unicos sin repetidos*/
SELECT [Espectaculo_Cod] id
      ,[Espectaculo_Descripcion] descripcion
      --,[Espectaculo_Fecha] se agrega en tabla Ubicac_X_Espectaculo
      ,[Espectaculo_Fecha_Venc] venc_publicacion
      ,[Espectaculo_Rubro_Descripcion] rubro
      ,[Espectaculo_Estado] estado
	  ,left(Espec_Empresa_Mail,charindex('@',Espec_Empresa_Mail,1)-1) usuario
into #TEMP_Espectaculo
  FROM [GD2C2018].[gd_esquema].[Maestra]
  group by [Espectaculo_Cod]
      ,[Espectaculo_Descripcion]
      --,[Espectaculo_Fecha]
      ,[Espectaculo_Fecha_Venc]
      ,[Espectaculo_Rubro_Descripcion]
      ,[Espectaculo_Estado]
	  ,left(Espec_Empresa_Mail,charindex('@',Espec_Empresa_Mail,1)-1)
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
			)
	select t.id
			,u.id_usuario
			,1--rubro 'No Definido'
			,t.venc_publicacion
			,t.descripcion
			,e.id_estado_publicacion
			,1--grado de publicacion 'No Definido'
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
		  ,[Ubicacion_Fila]
		  ,[Ubicacion_Asiento]
		  ,[Ubicacion_Sin_numerar]
		  ,[Ubicacion_Precio]
		  ,[Ubicacion_Tipo_Codigo]
		  ,[Ubicacion_Tipo_Descripcion]
	order by [Espectaculo_Cod]
	--238.143

	insert into [LOOPP].[Ubicac_X_Espectaculo] (
				[id_espectaculo]
				,[id_ubicacion]
				,[precio]
				,[fecha_espectaculo]
				,[hora_espectaculo])
	select e.id_espectaculo
		  ,u.id_ubicacion
		  ,t.Ubicacion_Precio
		  ,cast(t.Espectaculo_Fecha as date) fecha
		  ,'00:00:00' hora
	from #Temp_Ubic_Espec t
	inner join [LOOPP].[Espectaculos] e
		on t.Espectaculo_Cod=e.id_espectaculo
	inner join [LOOPP].[Ubicaciones] u
		on t.Ubicacion_Fila=u.fila and t.Ubicacion_Asiento=u.asiento
	inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion and t.Ubicacion_Tipo_Descripcion=tu.descripcion
	order by e.id_espectaculo,u.id_ubicacion

	Drop table #Temp_Ubic_Espec;
-------------------------------------------------------------------------------

/*Migracion de Facturas*/

/*Se genera una tabla temporal con los datos unicos sin repetidos*/
SELECT [Espec_Empresa_Cuit]
      ,[Espectaculo_Cod]
	  ,[Espectaculo_Fecha]
      ,[Factura_Nro]
      ,[Factura_Fecha]
      ,[Factura_Total]
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
		   ,[id_empresa]
		   ,[id_espectaculo])
select t.Factura_Nro
	  ,t.Factura_Fecha
	  ,t.Factura_Total
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
