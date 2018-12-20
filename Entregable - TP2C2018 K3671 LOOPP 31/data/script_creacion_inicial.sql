USE [GD2C2018]
GO

IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'LOOPP')) 
BEGIN
    EXEC ('CREATE SCHEMA [LOOPP]')
END

/*BORRADO DE ENTIDADES*/

	IF OBJECT_ID('LOOPP.Registro_Puntos') IS NOT NULL
		DROP TABLE [LOOPP].[Registro_Puntos];
	IF OBJECT_ID('LOOPP.Localidades_Vendidas') IS NOT NULL
		DROP TABLE [LOOPP].[Localidades_Vendidas];
	IF OBJECT_ID('LOOPP.Item_Factura') IS NOT NULL
		DROP TABLE [LOOPP].[Item_Factura];
	IF OBJECT_ID('LOOPP.Facturas') IS NOT NULL
		DROP TABLE [LOOPP].[Facturas];
	IF OBJECT_ID('LOOPP.Compras') IS NOT NULL
		DROP TABLE [LOOPP].[Compras];
	IF OBJECT_ID('LOOPP.Formas_Pago_Cliente') IS NOT NULL
		DROP TABLE [LOOPP].[Formas_Pago_Cliente];
	IF OBJECT_ID('LOOPP.Canjes') IS NOT NULL
		DROP TABLE [LOOPP].Canjes;
	IF OBJECT_ID('LOOPP.Catalogo_Canjes') IS NOT NULL
		DROP TABLE [LOOPP].Catalogo_Canjes;
	IF OBJECT_ID('LOOPP.Rol_X_Usuario') IS NOT NULL
		DROP TABLE [LOOPP].[Rol_X_Usuario];
	IF OBJECT_ID('LOOPP.Tarjetas_Asociadas') IS NOT NULL
		DROP TABLE [LOOPP].[Tarjetas_Asociadas];
	IF OBJECT_ID('LOOPP.Clientes') IS NOT NULL
		DROP TABLE [LOOPP].[Clientes];
	IF OBJECT_ID('LOOPP.Ubicac_X_Espectaculo') IS NOT NULL
		DROP TABLE [LOOPP].[Ubicac_X_Espectaculo];
	IF OBJECT_ID('LOOPP.Ubicaciones') IS NOT NULL
		DROP TABLE [LOOPP].[Ubicaciones];
	IF OBJECT_ID('LOOPP.Tipo_Ubicacion') IS NOT NULL
		DROP TABLE [LOOPP].[Tipo_Ubicacion];
	IF OBJECT_ID('LOOPP.Espectaculos') IS NOT NULL
		DROP TABLE [LOOPP].[Espectaculos];
	IF OBJECT_ID('LOOPP.Rubros') IS NOT NULL
		DROP TABLE [LOOPP].[Rubros];
	IF OBJECT_ID('LOOPP.Grados_Publicacion') IS NOT NULL
		DROP TABLE [LOOPP].[Grados_Publicacion];
	IF OBJECT_ID('LOOPP.Estados_Publicacion') IS NOT NULL
		DROP TABLE [LOOPP].[Estados_Publicacion];
	IF OBJECT_ID('LOOPP.Empresas') IS NOT NULL
		DROP TABLE [LOOPP].[Empresas];
	IF OBJECT_ID('LOOPP.Usuarios') IS NOT NULL
		DROP TABLE [LOOPP].[Usuarios];
	IF OBJECT_ID('LOOPP.Func_X_Rol') IS NOT NULL
		DROP TABLE [LOOPP].[Func_X_Rol];
	IF OBJECT_ID('LOOPP.Funcionalidades') IS NOT NULL
		DROP TABLE [LOOPP].[Funcionalidades];
	IF OBJECT_ID('LOOPP.Roles') IS NOT NULL
		DROP TABLE [LOOPP].[Roles];
	IF OBJECT_ID('LOOPP.Formas_Pago') IS NOT NULL
		DROP TABLE [LOOPP].[Formas_Pago];
	

/*##########################################################################################################*/
/*										CREACION DE TABLAS													*/
/*##########################################################################################################*/
Print '***Inicio de creacion de tablas***'
	/*-1- Tabla Roles*/
	CREATE TABLE [LOOPP].[Roles](	
		[id_rol] int IDENTITY(1,1) NOT NULL,
		[nombre] varchar (50) NOT NULL,
		[baja_logica] bit NOT NULL DEFAULT('False'),
		primary key ([id_rol])
	) 

	/*-2- Tabla Funcionalidades*/
	CREATE TABLE [LOOPP].[Funcionalidades](
		id_funcionalidad int IDENTITY(1,1) NOT NULL,
		nombre varchar(30) NOT NULL,
		primary key ([id_funcionalidad])
	) 

	/*-3- Tabla Funcionalidad por Rol*/
	CREATE TABLE [LOOPP].[Func_X_Rol](
		[id_funcionalidad] [int] NOT NULL,
		[id_rol] [int] NOT NULL,
		[baja_logica] bit NOT NULL DEFAULT('False'),
		PRIMARY KEY ( [id_funcionalidad], [id_rol]),
		foreign key ([id_funcionalidad]) references [LOOPP].[Funcionalidades]([id_funcionalidad]),
		foreign key ([id_rol]) references [LOOPP].[Roles]([id_rol])
	) 
	
	/*-4- Tabla Usuarios*/
	CREATE TABLE [LOOPP].[Usuarios](
		[id_usuario] [int] IDENTITY(1,1) NOT NULL,
		[username] [varchar](255) NOT NULL,
		[password] [varchar](255) NOT NULL,
		[loginFallidos] int NOT NULL DEFAULT (0),
		[habilitado] bit NOT NULL DEFAULT('True'),
		[primerLoginAuto] bit NOT NULL DEFAULT('False'),
		primary key ([id_usuario])
	) 

	/*-5- Tabla Rol por Usuario*/
	CREATE TABLE [LOOPP].[Rol_X_Usuario](
		[id_usuario] [int] NOT NULL,
		[id_rol] [int] NOT NULL,
		[activo] bit NOT NULL DEFAULT('True'),
		PRIMARY KEY ( [id_usuario], [id_rol]),
		foreign key ([id_usuario]) references [LOOPP].[Usuarios]([id_usuario]),
		foreign key ([id_rol]) references [LOOPP].[Roles]([id_rol])
	) 

	/*-6- Tabla Empresas*/
	CREATE TABLE LOOPP.Empresas(
		id_empresa int identity(1,1) NOT NULL,
		razon_social nvarchar(255) NOT NULL,
		cuit nvarchar(255) NOT NULL,
		fecha_creacion datetime NULL,
		mail nvarchar(50) NULL DEFAULT ('No definido'),
		telefono nvarchar(15) NULL DEFAULT ('No definido'),
		direccion_calle nvarchar(50) NULL DEFAULT ('No definido'),
		direccion_nro numeric(18, 0) NULL DEFAULT ('0'),
		direccion_piso numeric(18, 0) NULL DEFAULT ('0'),
		direccion_depto nvarchar(50) NULL DEFAULT ('No definido'),
		direccion_localidad nvarchar(50) NULL DEFAULT ('No definido'),
		cod_postal nvarchar(50) NULL DEFAULT ('No definido'),
		ciudad nvarchar(50) NULL DEFAULT ('No definido'),
		baja_logica bit NOT NULL DEFAULT('False'),
		id_usuario int not null,
		UNIQUE (cuit),
		primary key ([id_empresa]),
		foreign key ([id_usuario]) references [LOOPP].[Usuarios]([id_usuario])
	) 

	/*-7- Tabla Estados de Publicacion*/
	CREATE TABLE LOOPP.Estados_Publicacion(
		id_estado_publicacion int identity(1,1) NOT NULL,
		descripcion nvarchar(255) NOT NULL,
		primary key ([id_estado_publicacion])
	) 

	/*-8- Tabla Grados de Publicacion*/
	CREATE TABLE LOOPP.Grados_Publicacion(
		id_grado_publicacion int identity(1,1) NOT NULL,
		activo bit NOT NULL DEFAULT('True'),
		comision numeric(10,2) NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		primary key ([id_grado_publicacion])
	) 

	/*-9- Tabla Rubros*/
	CREATE TABLE LOOPP.Rubros(
		id_rubro int identity(1,1) NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		primary key ([id_rubro])
	) 

	/*-10- Tabla Espectaculos*/
	CREATE TABLE LOOPP.Espectaculos(
		id_espectaculo int NOT NULL,
		id_usuario_responsable int not null,
		id_rubro int not null,
		fecha_publicacion datetime NOT NULL,
		descripcion nvarchar(255) NOT NULL,
		direccion nvarchar(50) NULL DEFAULT ('No definido'),
		id_estado_publicacion int not null,
		id_grado_publicacion int not null,
		precio_base numeric(18,2) NOT null DEFAULT(0.00),
		[fecha_espectaculo] date not null,
		[fecha_venc_espectaculo] date not null,
		[hora_espectaculo] time not null,
		primary key ([id_espectaculo]),
		foreign key ([id_usuario_responsable]) references [LOOPP].[Usuarios]([id_usuario]),
		foreign key ([id_rubro]) references [LOOPP].[Rubros]([id_rubro]),
		foreign key ([id_estado_publicacion]) references [LOOPP].[Estados_Publicacion]([id_estado_publicacion]),
		foreign key ([id_grado_publicacion]) references [LOOPP].[Grados_Publicacion]([id_grado_publicacion])
	) 

	/*-11- Tabla Tipo de Ubicacion*/
	CREATE TABLE LOOPP.Tipo_Ubicacion(
		id_tipo_ubicacion int  NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		porcentual numeric(10,2) NOT null,
		primary key ([id_tipo_ubicacion])
	) 

	/*-12- Tabla Ubicaciones*/
	CREATE TABLE LOOPP.Ubicaciones(
		id_ubicacion int identity(1,1) NOT NULL,
		fila varchar(3) NOT NULL,
		asiento numeric(18, 0) NOT NULL,
		sin_numerar bit NULL DEFAULT('False'),
		id_tipo_ubicacion int not null,
		primary key ([id_ubicacion]),
		foreign key ([id_tipo_ubicacion]) references [LOOPP].[Tipo_Ubicacion]([id_tipo_ubicacion])
	) 

	/*-13- Tabla Ubicacion por espectaculo*/
	CREATE TABLE [LOOPP].[Ubicac_X_Espectaculo](
		[id_espectaculo] [int] NOT NULL,
		[id_ubicacion] [int] NOT NULL,
		[precio] numeric(18,2) NOT null,
		[disponible] bit not null DEFAULT('True'),
		PRIMARY KEY ([id_espectaculo], [id_ubicacion]),
		foreign key ([id_espectaculo]) references [LOOPP].[Espectaculos]([id_espectaculo]),
		foreign key ([id_ubicacion]) references [LOOPP].[Ubicaciones]([id_ubicacion])
	) 

	/*-14- Tabla Clientes*/
	CREATE TABLE LOOPP.Clientes(
		id_cliente int identity(1,1) NOT NULL,
		estado nvarchar(50) NOT NULL DEFAULT('Habilitado'),
		baja_logica bit DEFAULT ('False'),		
		nombre nvarchar(255) NOT NULL,
		apellido nvarchar(255) NOT NULL,
		tipo_documento nvarchar(20) NOT NULL DEFAULT('DNI'),
		nro_documento numeric(18,0) NOT NULL,
		cuil nvarchar(15) NULL DEFAULT ('No definido'),
		mail nvarchar(255) NOT NULL DEFAULT ('No definido'),
		telefono nvarchar(15) NULL DEFAULT ('No definido'),
		direccion_calle nvarchar(255) NULL DEFAULT ('No definido'),
		direccion_nro numeric(18, 0) NULL DEFAULT ('0'),
		direccion_piso numeric(18, 0) NULL DEFAULT ('0'),
		direccion_depto nvarchar(255) NULL DEFAULT ('No definido'),
		direccion_localidad nvarchar(255) NULL DEFAULT ('No definido'),
		codigo_postal nvarchar(255) NULL DEFAULT ('No definido'),
		fecha_nacimiento datetime NULL,
		fecha_creacion datetime NULL,
		id_usuario int NOT NULL,
		CONSTRAINT UC_Cliente UNIQUE (tipo_documento,nro_documento),
		primary key ([id_cliente]),
		foreign key ([id_usuario]) references [LOOPP].[Usuarios]([id_usuario])
	) 

	
	/*-15- Formas de Pago*/
	CREATE TABLE LOOPP.Formas_Pago(
		id_forma_pago int identity(1,1) NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		marca nvarchar(20),
		primary key ([id_forma_pago]),
	) 


	/*-15- Formas de Pago Cliente*/
	CREATE TABLE LOOPP.Formas_Pago_Cliente(
		id_forma_pago_cliente int identity(1,1) NOT NULL,
		id_forma_pago int NOT NULL,
		nro_tarjeta bigint,
		id_cliente int NOT NULL,
		primary key ([id_forma_pago_cliente]),
		foreign key (id_cliente) references [LOOPP].[Clientes](id_cliente),
		foreign key (id_forma_pago) references [LOOPP].[Formas_Pago](id_forma_pago)
	) 
	
	/*-16- Catalogo de canjes*/
	CREATE TABLE LOOPP.Catalogo_Canjes(
		id_codigo int identity(1,1) NOT NULL,
		stock numeric(18, 0) not null,
		descripcion	nvarchar(30) NOT NULL,
		puntos_validos numeric(18, 0) not NULL,
		primary key ([id_codigo])
	) 

	/*-17- Canjes*/
	CREATE TABLE LOOPP.Canjes(
		id_canje int identity(1,1) NOT NULL,
		fecha_canje datetime NOT NULL,
		puntos_canjeados numeric(18, 0) not NULL,
		id_codigo int NOT NULL,
		id_cliente int NOT NULL,
		primary key ([id_canje]),
		foreign key (id_codigo) references [LOOPP].[Catalogo_Canjes](id_codigo),
		foreign key (id_cliente) references [LOOPP].[Clientes](id_cliente)
	) 

	/*-18- Tabla Compras*/
	CREATE TABLE LOOPP.Compras(
		id_compra int identity(1,1) NOT NULL,
		fecha_compra datetime NOT NULL,
		importe_total numeric(18, 0) NOT NULL,
		cantidad_compra numeric(18, 0) NOT NULL,
		id_forma_pago_cliente int NOT NULL,
		puntos  int NOT NULL DEFAULT('0'),
		id_cliente int NOT NULL,
		facturado bit not null DEFAULT('False'),
		primary key ([id_compra]),
		foreign key ([id_forma_pago_cliente]) references [LOOPP].[Formas_Pago_Cliente]([id_forma_pago_cliente]),
		foreign key (id_cliente) references [LOOPP].[Clientes](id_cliente)
		
	) 

	/*-19- Tabla Facturas*/
	CREATE TABLE LOOPP.Facturas(
		nro_factura int NOT NULL,
		fecha_factura datetime NOT NULL,
		total_factura numeric(18, 2) NOT NULL,
		total_comision numeric(18, 2) NOT NULL,
		id_empresa int NOT NULL,
		id_espectaculo int NOT NULL,
		primary key ([nro_factura]),
		foreign key ([id_empresa]) references [LOOPP].[Empresas]([id_empresa]),
		foreign key ([id_espectaculo]) references [LOOPP].[Espectaculos]([id_espectaculo])
	) 

	/*-20- Tabla Items Factura*/
	CREATE TABLE LOOPP.Item_Factura(
		nro_item int identity(1,1) NOT NULL,
		nro_factura int NOT NULL,
		monto_compra numeric(18, 2) NOT NULL,
		monto_comision numeric(18, 2) NOT NULL,
		cantidad numeric(18, 0) NOT NULL,
		descripcion nvarchar(60) NOT NULL,
		primary key ([nro_item]),
		foreign key ([nro_factura]) references [LOOPP].[Facturas]([nro_factura])
	) 


	/*-21- Tabla Localidades vendidas*/
	CREATE TABLE LOOPP.Localidades_Vendidas(
		id_compra int NOT NULL,
		id_espectaculo int NOT NULL,
		id_ubicacion int NOT NULL,
		primary key (id_compra,id_espectaculo,id_ubicacion),
		foreign key (id_compra) references [LOOPP].[Compras](id_compra),
		foreign key (id_espectaculo) references [LOOPP].[Espectaculos](id_espectaculo),
		foreign key (id_ubicacion) references [LOOPP].[Ubicaciones](id_ubicacion)
	) 
	
	/*22-Creacion de tabla de puntos */
	CREATE TABLE LOOPP.Registro_Puntos(
		id_compra int NOT NULL,
		id_cliente int NOT NULL,
		puntos_usados int,
		fecha_vencimiento datetime,
		primary key (id_compra,id_cliente),
		foreign key (id_compra) references [LOOPP].[Compras](id_compra),
		foreign key (id_cliente) references [LOOPP].[Clientes](id_cliente)
	) 
	

Print '***Fin de creacion de tablas***'
GO
Print '***Creacion Triggers***'
GO
create trigger TR_CrearRegistroPuntos on LOOPP.Compras
after insert
as
	BEGIN TRANSACTION [T]

	BEGIN TRY

	insert into LOOPP.Registro_Puntos (id_cliente, id_compra,puntos_usados, fecha_vencimiento)
	select id_cliente, id_compra, 0, DATEADD(month, 6, fecha_compra)
	from inserted
	COMMIT TRANSACTION [T]

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	END CATCH;
GO
Print '***Fin Creacion Triggers***'

/*##########################################################################################################*/
/*										MIGRACION DE DATOS													*/
/*##########################################################################################################*/

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
INSERT INTO LOOPP.Catalogo_Canjes (stock, descripcion, puntos_validos) VALUES ( 10, 'Una consumición gratis', 300);
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

    Return Lower( replace(@Temp, 'nº', ''))
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

/*##########################################################################################################*/
/*										CREACION DE SPs y FN												*/
/*##########################################################################################################*/

-------------------------------------------------------------------

/*LOOPP.SP_AltaUsuario_Autogenerado*/

IF OBJECT_ID('LOOPP.SP_AltaUsuario_Autogenerado') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_AltaUsuario_Autogenerado];
GO

CREATE PROCEDURE [LOOPP].[SP_AltaUsuario_Autogenerado] ( @cuitCuil nvarchar(15), @nombre nvarchar(255))
AS
Begin
	DECLARE @id int, @nuevoUser varchar(255), @pass varchar(255)
	SET @nuevoUser = @cuitCuil
	SET @pass = '1234'
	INSERT INTO LOOPP.Usuarios (username, password,primerLoginAuto)
	VALUES (@nuevoUser,@pass, 'True')
	SELECT @id=SCOPE_IDENTITY() 
	FROM [LOOPP].[Usuarios]	 
	RETURN @id
End
GO
/* LOOPP.SP_NuevoCliente */

IF OBJECT_ID('LOOPP.SP_NuevoCliente') IS NOT NULL
DROP PROCEDURE LOOPP.SP_NuevoCliente
GO

CREATE PROCEDURE LOOPP.SP_NuevoCliente
	@nombre varchar(255)
   ,@apellido varchar(255)
   ,@tipo_doc varchar(20)
   ,@documento numeric(18,0)
   ,@cuil varchar(15)
   ,@fecha_nac datetime
   ,@mail varchar(255)
   ,@telefono varchar(15)
   ,@calle varchar(255)
   ,@nroCalle numeric(18,0)
   ,@piso numeric(18,0)
   ,@depto varchar(255)
   ,@localidad varchar(255)
   ,@cod_postal varchar(255)
   ,@user varchar(255)
   ,@pass varchar(255)

AS
	declare @resultado varchar(255), @idUsu int, @idCliente int
	BEGIN TRANSACTION [T]

	BEGIN TRY
		/*En el momento de crear usuarios, el campo username tiene una constraint de unicidad, si ya existe uno igual dara error de constraint*/
		if ( @user is null)
			begin
				EXEC @idUsu =  LOOPP.SP_AltaUsuario_Autogenerado @cuil, @nombre

				select @pass = password, @user= username
				from LOOPP.usuarios
				where id_usuario = @idUsu
			end
		else
			begin
				insert into [LOOPP].[Usuarios](
							[username]
							,[password])
				values (@user,@pass);
				select @idUsu=[id_usuario]
				from [LOOPP].[Usuarios]
				where [username]=@user;
		end
		INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol)
		VALUES (@idUsu,2);

		if not exists (select 1 from [LOOPP].[Clientes] where (tipo_documento=@tipo_doc and nro_documento=@documento) or mail=@mail)
		begin
			insert into [LOOPP].[Clientes] (
					   [nombre]
					  ,[apellido]
					  ,[tipo_documento]
					  ,[nro_documento]
					  ,[cuil]
					  ,[fecha_nacimiento]
					  ,[mail]
					  ,[telefono]
					  ,[direccion_calle]
					  ,[direccion_nro]
					  ,[direccion_piso]
					  ,[direccion_depto]
					  ,[direccion_localidad]
					  ,[codigo_postal]
					  ,[id_usuario] )
			values (@nombre,@apellido,@tipo_doc,@documento,@cuil,@fecha_nac,@mail,@telefono,@calle,@nroCalle,@piso,@depto,@localidad,@cod_postal,@idUsu)
			SELECT @idCliente=SCOPE_IDENTITY()
			FROM LOOPP.Clientes
		end
		else
			RAISERROR('El cliente ya existe en el sistema',16,1)
	SET @resultado = 'OK'


	COMMIT TRANSACTION [T]

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]
			set @resultado = 'ERROR: '+ERROR_MESSAGE()
			SET @idCliente=0

	END CATCH;
	select @resultado as 'resultadoCliente',  @idUsu as 'id_usuario', @idCliente as 'id_cliente', @user as 'username', @pass as 'password'
GO
---------------------------------------------------------------------------------------

/* LOOPP.SP_FiltrarClientes */

IF OBJECT_ID('LOOPP.SP_FiltrarClientes') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_FiltrarClientes];
GO

CREATE PROCEDURE [LOOPP].[SP_FiltrarClientes]
	@nombre nvarchar(255),
	@apellido nvarchar(255),
	@email nvarchar(255),
	@nroDoc numeric(18,0)

AS
BEGIN
	SELECT C.id_cliente, C.apellido, C.nombre, C.mail, C.tipo_documento, C.nro_documento, C.fecha_nacimiento, C.direccion_calle, C.direccion_nro, C.direccion_localidad, C.estado, C.baja_logica
	FROM [LOOPP].Clientes as C
	WHERE (C.nombre LIKE '%'+@nombre+'%' OR @nombre IS NULL OR @nombre = '')
	AND (C.apellido LIKE '%'+@apellido+'%' OR @apellido IS NULL OR @apellido = '')
	AND (C.mail LIKE '%'+@email+'%' OR @email IS NULL OR @email = '')
	AND (C.nro_documento = @nroDoc OR @nroDoc IS NULL OR @nroDoc=0)
END
GO

-------------------------------------------------------------------------
/* LOOPP.SP_GetClientePorId */

IF OBJECT_ID('LOOPP.SP_GetClientePorId') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetClientePorId];
GO
CREATE PROCEDURE [LOOPP].[SP_GetClientePorId]
	
	@idCliente int
AS
BEGIN
	SELECT * FROM Clientes WHERE id_cliente=@idCliente
END
GO

--------------------------------------------------------------------------
/* LOOPP.SP_ModificarCliente */

IF OBJECT_ID('LOOPP.SP_ModificarCliente') IS NOT NULL
DROP PROCEDURE LOOPP.SP_ModificarCliente
GO

CREATE PROCEDURE [LOOPP].[SP_ModificarCliente]
	@nombre varchar(255)
   ,@apellido varchar(255)
   ,@tipo_doc varchar(20)
   ,@documento numeric(18,0)
   ,@cuil varchar(15)
   ,@fecha_nac datetime
   ,@mail varchar(255)
   ,@telefono varchar(15)
   ,@calle varchar(255)
   ,@nroCalle numeric(18,0)
   ,@piso numeric(18,0)
   ,@depto varchar(255)
   ,@localidad varchar(255)
   ,@cod_postal varchar(255)
   ,@baja_logica bit
   ,@idCliente int
   ,@estaInhabilitado bit
  
  AS
	declare @resultado varchar(255), @iduser int, @estado nvarchar(50)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		IF EXISTS (SELECT 1 FROM LOOPP.Clientes  WHERE cuil = @cuil and id_cliente != @idCliente)
		BEGIN
			RAISERROR('Ya se encuentra registrado un cliente con el mismo CUIL',16,1)
		END
		ELSE IF EXISTS (SELECT 1 FROM LOOPP.Clientes  WHERE mail = @mail and id_cliente != @idCliente)
		BEGIN
			RAISERROR('Ya se encuentra registrado un cliente con el mismo email',16,1)
		END
		select @iduser= id_usuario, @estado=estado
		from LOOPP.Clientes
		where id_cliente=@idCliente
		if (@estado = 'Inconsistente')
			 SET @estado = 'Habilitado'
	
		UPDATE LOOPP.Clientes
		SET
			nombre=@nombre,
			apellido=@apellido,
			tipo_documento=@tipo_doc,
			nro_documento=@documento,
			fecha_nacimiento=@fecha_nac,
			cuil=@cuil,
			mail=@mail,
			telefono=@telefono,
			direccion_calle=@calle,
			direccion_nro=@nroCalle,
			direccion_piso=@piso,
			direccion_depto=@depto,
			direccion_localidad=@localidad,
			
			codigo_postal=@cod_postal,
			baja_logica=@baja_logica,
			estado=@estado
		WHERE id_cliente=@idCliente
	
		UPDATE LOOPP.Usuarios
			SET habilitado=~@estaInhabilitado
			where id_usuario=@iduser

		if (@baja_logica ='True')
			begin
				UPDATE LOOPP.Usuarios
					SET habilitado='False'
					WHERE id_usuario= @iduser
			end
		else
			begin
				UPDATE LOOPP.Usuarios
						SET habilitado='True'
						WHERE id_usuario= @iduser
			end
		

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
	
GO

-----------------------------------------------------------------------
/* LOOPP.SP_UserHasInvalidInfo */

IF OBJECT_ID('LOOPP.SP_UserHasInvalidInfo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_UserHasInvalidInfo
GO

create procedure LOOPP.SP_UserHasInvalidInfo (@id_user int)
as
begin

	declare @result bit
	select @result=case when estado='Inconsistente' then 1 else 0 end
	from LOOPP.Clientes	
	where id_usuario=@id_user
	if @result is null 
	begin
		set @result=0
	end
	select @result
end
GO

-----------------------------------------------------------------------
/*Funcion que calcula precio de entrada segun ubicacion*/

IF OBJECT_ID('LOOPP.Fn_PrecioXUbicacion') IS NOT NULL
    DROP FUNCTION LOOPP.Fn_PrecioXUbicacion
GO

create function LOOPP.Fn_PrecioXUbicacion (@gradoPub int, @id_ubicacion int,@precioBase numeric(18,2))
RETURNS numeric(18,2)
AS 
	BEGIN
		declare @precioEntrada numeric(18,2);
		declare @porcXUbic numeric (10,2);
		declare @comision numeric (10,2);

		select @porcXUbic = porcentual
		from LOOPP.Ubicaciones u
		inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
		where id_ubicacion = @id_ubicacion

		select @comision=comision
		from [LOOPP].[Grados_Publicacion]
		where id_grado_publicacion=@gradoPub;

		set @precioEntrada = @precioBase + (@precioBase*@porcXUbic) + (@precioBase*@comision);
	
		RETURN @precioEntrada
	END
GO
/*Inserta ubicacion por espectaculo con el precio segun ubicacion*/
IF OBJECT_ID('LOOPP.SP_NuevaUbicac_X_Espectaculo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevaUbicac_X_Espectaculo
GO

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

IF OBJECT_ID('LOOPP.SP_NuevaPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevaPublicacion
GO

/*Inserta espectaculo nuevo y ubicacion por espectaculo con el precio segun ubicacion*/
create procedure LOOPP.SP_NuevaPublicacion @descripcion nvarchar(255)
										  ,@direccion nvarchar(50)
										  ,@id_grado_publicacion int
										  ,@id_estado int
										  ,@rubro int
										  ,@id_usuario int
										  ,@fecha_publicacion datetime
										  ,@precio_base numeric(18,2)
										  ,@fechaEspec date
										  ,@horaEspec nvarchar(50)
										  ,@fechaVenc date
AS
	declare @resultado int;
	declare @newId int;
	declare @timeEspec time;
	set @timeEspec = CONVERT( TIME, @horaEspec )
	select @newId=MAX([id_espectaculo])+1
	from [LOOPP].[Espectaculos];

	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.id_espectaculo=ue.id_espectaculo
				   where e.descripcion=@descripcion 
				   and e.fecha_publicacion=@fecha_publicacion
				   and e.fecha_espectaculo=@fechaEspec
				   and e.hora_espectaculo=@timeEspec
				   and id_estado_publicacion in (1,2,3))
	begin
		insert into [LOOPP].[Espectaculos]([id_espectaculo]
											,[id_usuario_responsable]
											,[id_rubro]
											,[fecha_publicacion]
											,[descripcion]
											,[direccion]
											,[id_estado_publicacion]
											,[id_grado_publicacion]
											,[precio_base]
											,[fecha_espectaculo]
											,[fecha_venc_espectaculo]
											,[hora_espectaculo])
		values (@newId,@id_usuario,@rubro,@fecha_publicacion,@descripcion,@direccion,@id_estado,@id_grado_publicacion,@precio_base,@fechaEspec, @fechaVenc, @timeEspec)

		set @resultado = @newId

	end
	else set @resultado = -1;

	select @resultado;

GO

----------------------------------------------------------------------------------

/*LOOPP.SP_NuevoEmpresa */

IF OBJECT_ID('LOOPP.SP_NuevoEmpresa') IS NOT NULL
DROP PROCEDURE LOOPP.SP_NuevoEmpresa
GO

CREATE PROCEDURE [LOOPP].[SP_NuevoEmpresa]
@razon varchar(255)
,@cuit varchar(255)
,@email varchar(50)
,@tel varchar(15)
,@dir varchar(50)
,@dir_nro numeric(18,0)
,@dir_piso numeric(18,0)
,@dir_depto varchar(50)
,@localidad varchar(50)
,@ciudad varchar(50)
,@codPostal varchar(50)
,@user varchar(255)
,@pass varchar(255)
,@fec_creacion datetime
AS
declare @resultado varchar(255)
BEGIN TRANSACTION [T]

BEGIN TRY
	/*En el momento de crear usuarios, el campo username tiene una constraint de unicidad, si ya existe uno igual dara error de constraint*/
	declare @idUsu int;
	if ( @user is null)
		begin
			EXEC @idUsu =  LOOPP.SP_AltaUsuario_Autogenerado @cuit, @razon
			SET @resultado = CONVERT(varchar(255), @idUsu)+';1234'
		end
	else
		begin
			insert into [LOOPP].[Usuarios](
						[username]
						,[password])
			values (@user,@pass);
		
		
			select @idUsu=[id_usuario]
			from [LOOPP].[Usuarios]
			where [username]=@user;
			SET @resultado = CONVERT(varchar(255), @idUsu)+';'
	end
	INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) 
	VALUES (@idUsu,3);

	if not exists (select 1 from [LOOPP].[Empresas] where cuit=@cuit or [mail]=@email or [razon_social]=@razon)
	begin
		insert into [LOOPP].[Empresas](
					[razon_social]
					,[cuit]
					,[fecha_creacion]
					,[mail]
					,[telefono]
					,[direccion_calle]
					,[direccion_nro]
					,[direccion_piso]
					,[direccion_depto]
					,[direccion_localidad]
					,[cod_postal]
					,[ciudad]
					,[id_usuario] )
		values (@razon,@cuit,@fec_creacion,@email,@tel,@dir,@dir_nro,@dir_piso,@dir_depto,@localidad,@codPostal,@ciudad,@idUsu)
	end
	else
		RAISERROR('La empresa ya existe en el sistema',16,1)
	
COMMIT TRANSACTION [T]

set @resultado = @resultado +';OK';

END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION [T]

	set @resultado = ERROR_MESSAGE()+';;ERROR';

END CATCH;
SELECT @resultado
GO
----------------------------------------------------------------------------
/* LOOPP.SP_EsPrimerLogueo */

IF OBJECT_ID('LOOPP.SP_EsPrimerLogueo') IS NOT NULL
DROP PROCEDURE LOOPP.SP_EsPrimerLogueo
GO

CREATE PROCEDURE LOOPP.SP_EsPrimerLogueo (@id_user int)
as
begin
DECLARE @result bit, @esPrimerLogin bit
	
	SELECT @esPrimerLogin=primerLoginAuto
	FROM LOOPP.Usuarios
	WHERE id_usuario=@id_user

	if ( @esPrimerLogin='True')
	
		set @result='True'
	
	else
		set @result='False'
	select @result
End
GO
---------------------------------------------------------------
/* LOOPP.SP_GetEmpresaPorId */

IF OBJECT_ID('LOOPP.SP_GetEmpresaPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEmpresaPorId
GO
CREATE PROCEDURE [LOOPP].[SP_GetEmpresaPorId]
	
	@idEmpresa int
AS
BEGIN
	SELECT * FROM Empresas WHERE id_empresa=@idEmpresa
END
GO
----------------------------------------------------------------
/*LOOPP.SP_InhabilitarRol*/

IF OBJECT_ID('LOOPP.SP_InhabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarRol
GO

CREATE PROCEDURE [LOOPP].[SP_InhabilitarRol] @idRol int
AS
	declare @resultado varchar(10);
	if not exists (select 1 from [LOOPP].[Rol_X_Usuario] ru
				   inner join [LOOPP].[Usuarios] u on ru.id_usuario=u.id_usuario
				   inner join [LOOPP].[Espectaculos] e on u.id_usuario=e.id_usuario_responsable
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue on e.id_espectaculo=ue.id_espectaculo
				   where ru.id_rol=@idRol 
				   and (GETDATE() between e.fecha_publicacion and e.fecha_espectaculo))
	begin
		update [LOOPP].[Rol_X_Usuario]
		set activo='False'
		where [id_rol]=@idRol;

		update [LOOPP].[Roles]
		set baja_logica = 'True'
		where id_rol=@idRol;

		set @resultado='OK'
	end
	else set @resultado='Error'

	Select @resultado;

GO

--------------------------------------------------------------------
/*LOOPP.SP_ModificarEmpresa*/

IF OBJECT_ID('LOOPP.SP_ModificarEmpresa') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ModificarEmpresa
GO

CREATE PROCEDURE [LOOPP].[SP_ModificarEmpresa]
	@idEmpresa int,
	@razon varchar(255)
   ,@cuit varchar(255)
   ,@email varchar(50)
   ,@tel varchar(15)
   ,@dir varchar(50)
   ,@dir_nro numeric(18,0)
   ,@dir_piso numeric(18,0)
   ,@dir_depto varchar(50)
   ,@localidad varchar(50)
   ,@ciudad varchar(50)
   ,@codPostal varchar(50)
   ,@bajaLogica bit
  AS
	declare @resultado varchar(255), @idUser int
	BEGIN TRANSACTION [T]

	BEGIN TRY
		IF EXISTS (SELECT 1 FROM LOOPP.Empresas  WHERE cuit = @cuit and id_empresa != @idEmpresa)
		BEGIN
			RAISERROR('Ya se encuentra registrado una empresa con el mismo CUIT',16,1)
		END
		ELSE IF EXISTS (SELECT 1 FROM LOOPP.Empresas  WHERE mail = @email and id_empresa != @idEmpresa)
		BEGIN
			RAISERROR('Ya se encuentra registrado una empresa con el mismo email',16,1)
		END
		IF EXISTS (SELECT 1 FROM LOOPP.Empresas  WHERE razon_social=@razon and id_empresa != @idEmpresa)
		BEGIN
			RAISERROR('Ya se encuentra registrado una empresa con la misma razon social',16,1)
		END
		select @iduser= id_usuario
			from LOOPP.Empresas
			where id_empresa=@idEmpresa
		UPDATE LOOPP.Empresas
		SET 
			razon_social=@razon,
			cuit=@cuit,
			mail=@email,
			telefono=@tel,
			direccion_calle=@dir,
			direccion_nro=@dir_nro,
			direccion_piso=@dir_piso,
			direccion_depto=@dir_depto,
			direccion_localidad=@localidad,
			ciudad=@ciudad,
			cod_postal=@codPostal,
			baja_logica=@bajaLogica
		WHERE id_empresa=@idEmpresa

		if (@bajaLogica ='True')
			begin
				UPDATE LOOPP.Usuarios
					SET habilitado='False'
					WHERE id_usuario= @idUser
			end
		else
			begin
				UPDATE LOOPP.Usuarios
						SET habilitado='True'
						WHERE id_usuario= @idUser
			end
	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
	GO
-----------------------------------------------------------------------------
/* SP_ABM_GradoPublicacion */

/*Alta de un nuevo grado de publicacion*/
IF OBJECT_ID('[LOOPP].[SP_NuevoGrado]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_NuevoGrado]
GO
CREATE PROCEDURE [LOOPP].[SP_NuevoGrado] @comision numeric(10,2),@descripcion nvarchar(20)
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Grados_Publicacion] where descripcion=@descripcion and comision=@comision)
		BEGIN
			insert into [LOOPP].[Grados_Publicacion] ([comision],[descripcion])
			values (@comision,@descripcion)

			set @resultado='OK'
		END
	else set @resultado = 'ERROR'
	select @resultado;
GO

/*Modificacion de un grado de publicacion*/
IF OBJECT_ID('[LOOPP].[SP_ModificarGrado]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_ModificarGrado]
GO
CREATE PROCEDURE [LOOPP].[SP_ModificarGrado] @id int,@comision numeric(10,2),@descripcion nvarchar(20)
AS
	declare @resultado varchar(10);

	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.[id_espectaculo]=ue.[id_espectaculo]
				   where id_grado_publicacion=@id
				   and getdate() between e.[fecha_publicacion] and e.[fecha_espectaculo]
				   )
		BEGIN
			if @descripcion is null and @comision is not null
			begin
				update [LOOPP].[Grados_Publicacion]
				set [comision]= @comision
				where id_grado_publicacion=@id
			end
			if @descripcion is not null and @comision is null
			begin
				update [LOOPP].[Grados_Publicacion]
				set [descripcion]= @descripcion
				where id_grado_publicacion=@id
			end
			if @descripcion is not null and @comision is not null
			begin
				update [LOOPP].[Grados_Publicacion]
				set [comision]= @comision,
					[descripcion]= @descripcion
				where id_grado_publicacion=@id
			end

			set @resultado='OK';
		END
	else set @resultado='ERROR'--EXISTEN PUBLICACIONES CON LA PRIORIDAD QUE SE QUIERE MODIFICAR

	select @resultado;
GO

/*Baja logica de un grado de publicacion*/
IF OBJECT_ID('[LOOPP].[SP_BajaLogicaGrado]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_BajaLogicaGrado]
GO
CREATE PROCEDURE [LOOPP].[SP_BajaLogicaGrado] @id int
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Espectaculos] e
				   inner join [LOOPP].[Ubicac_X_Espectaculo] ue
				   on e.[id_espectaculo]=ue.[id_espectaculo]
				   where id_grado_publicacion=@id
				   and getdate() between e.[fecha_publicacion] and e.[fecha_espectaculo])
		BEGIN
			update [LOOPP].[Grados_Publicacion]
			set [activo]='False'
			where id_grado_publicacion=@id

			set @resultado='OK';
		END
	else set @resultado='ERROR'--EXISTEN PUBLICACIONES CON LA PRIORIDAD QUE SE QUIERE INHABILITAR
	select @resultado;
GO

-----------------------------------------------------------------------
/*LOOPP.SP_AgregarFuncRol*/

IF OBJECT_ID('LOOPP.SP_AgregarFuncRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_AgregarFuncRol
GO

CREATE PROCEDURE [LOOPP].[SP_AgregarFuncRol] @idRol int, @idFunc int
AS
	declare @resultado varchar(10);

	if not exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc)
		begin
			insert into [LOOPP].[Func_X_Rol](id_rol,id_funcionalidad)
			values (@idRol,@idFunc);

			set @resultado='OK';
		end
	else
		begin
		if exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc)
			begin
				update [LOOPP].[Func_X_Rol]
				set baja_logica = 'False'
				where id_rol=@idRol 
				and id_funcionalidad=@idFunc;

				set @resultado='OK';
			end
		else set @resultado='ERROR';
		end
	
	select @resultado;
GO
------------------------------------------------------------------------
/*LOOPP.SP_AltaNuevoRol*/

IF OBJECT_ID('[LOOPP].[SP_AltaNuevoRol]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AltaNuevoRol]
GO
CREATE PROCEDURE [LOOPP].[SP_AltaNuevoRol] @nombre varchar(50)
AS
	declare @resultado varchar(10)
	if not exists (select 1 from [LOOPP].[Roles] where nombre=@nombre)
		BEGIN
			insert into [LOOPP].[Roles] (nombre)
			values (@nombre)
			
			SELECT @resultado = max(id_rol)
			from [LOOPP].[Roles]

		END
	else set @resultado = 'ERROR'

	select @resultado;

GO

-----------------------------------------------------------------------
/*LOOPP.SP_DevuelveItemsPorIdFactura*/

IF OBJECT_ID('LOOPP.SP_DevuelveItemsPorIdFactura') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_DevuelveItemsPorIdFactura];
GO

CREATE PROCEDURE [LOOPP].[SP_DevuelveItemsPorIdFactura] @idFactura int
AS
	select ifact.descripcion ubicacion
		  ,ifact.monto_compra importe_total
		  ,ifact.cantidad cantidad_compra
		  ,ifact.monto_comision comision
	from [LOOPP].[Item_Factura] ifact
	inner join [LOOPP].[Facturas] fact
		on ifact.nro_factura=fact.nro_factura
	where ifact.nro_factura = @idFactura
	order by ubicacion
GO
--------------------------------------------------------------------------------
/* LOOPP.SP_FiltrarEmpresas*/

IF OBJECT_ID('LOOPP.SP_FiltrarEmpresas') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_FiltrarEmpresas];
GO

CREATE PROCEDURE [LOOPP].[SP_FiltrarEmpresas]
	@cuit nvarchar(255),
	@razon_soc nvarchar(255),
	@email nvarchar(50)
AS
BEGIN
	SELECT E.id_empresa, E.razon_social, E.cuit, E.mail, E.telefono, E.direccion_calle, E.direccion_nro, E.ciudad, E.baja_logica
	FROM [LOOPP].Empresas as E
	WHERE (E.cuit = @cuit OR @cuit IS NULL OR @cuit = '')
	AND (E.razon_social LIKE '%'+@razon_soc+'%' OR @razon_soc IS NULL OR @razon_soc = '')
	AND (E.mail LIKE '%'+@email+'%' OR @email IS NULL OR @email = '')
	
END
GO

------------------------------------------------------------------------------------
/*LOOPP.SP_Funcionalidad_X_Rol*/

IF OBJECT_ID('LOOPP.SP_Funcionalidad_X_Rol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_Funcionalidad_X_Rol
GO

CREATE PROCEDURE [LOOPP].[SP_Funcionalidad_X_Rol]	@id_rol	int
AS
BEGIN
	select F.id_funcionalidad, F.nombre 
	from [LOOPP].[Funcionalidades] F 
	JOIN [LOOPP].[Func_X_Rol] FR ON (FR.ID_Funcionalidad = F.id_funcionalidad)
	JOIN [LOOPP].[Roles] R ON (R.id_rol=FR.id_rol)
	WHERE R.id_rol=@id_rol
	AND FR.baja_logica = 'False'
END
GO
---------------------------------------------------------------------------------------

/*LOOPP.SP_GetAllFuncionalidad*/

IF OBJECT_ID('LOOPP.SP_GetAllFuncionalidad') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllFuncionalidad
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllFuncionalidad]
AS
	select * from [LOOPP].[Funcionalidades]
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetAllRoles*/

IF OBJECT_ID('LOOPP.SP_GetAllRoles') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllRoles
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllRoles]
AS

	SELECT * 
	FROM [LOOPP].[Roles]

GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetAllRolesHab*/

IF OBJECT_ID('LOOPP.SP_GetAllRolesHab') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllRolesHab
GO

CREATE PROCEDURE [LOOPP].[SP_GetAllRolesHab]
AS
BEGIN
	SELECT * FROM LOOPP.Roles
	WHERE baja_logica='False'
	ORDER BY nombre
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetRolesIDUser*/

IF OBJECT_ID('LOOPP.SP_GetRolesIDUser') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetRolesIDUser];
GO

CREATE PROCEDURE [LOOPP].[SP_GetRolesIDUser]
	@id_user int
AS
BEGIN
	select * from [LOOPP].[Roles] R
	JOIN [LOOPP].Rol_X_Usuario as RxU on R.id_rol=RxU.id_rol 
	where id_usuario=@id_user
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetUsuario*/

IF OBJECT_ID('LOOPP.SP_GetUsuario') IS NOT NULL
	DROP PROCEDURE [LOOPP].[SP_GetUsuario];
GO

CREATE PROCEDURE [LOOPP].[SP_GetUsuario]
	@username varchar(255)
AS
BEGIN
	select * from [LOOPP].[Usuarios] U
	where username=@username
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_HabilitarRol */

IF OBJECT_ID('LOOPP.SP_HabilitarRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_HabilitarRol
GO

CREATE PROCEDURE [LOOPP].[SP_HabilitarRol] @idRol int
AS
	update [LOOPP].[Roles]
	set baja_logica = 'False'
	where id_rol=@idRol

GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_InhabilitarFunc_X_idRol */

IF OBJECT_ID('LOOPP.SP_InhabilitarFunc_X_idRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InhabilitarFunc_X_idRol
GO

CREATE PROCEDURE [LOOPP].[SP_InhabilitarFunc_X_idRol] @id_rol int
AS
	BEGIN
		update [LOOPP].[Func_X_Rol]
		set baja_logica = 'True'
		WHERE id_rol=@id_rol;
	END
GO
---------------------------------------------------------------------------------------
/*LOOPP.SP_QuitarFuncDeRol */

IF OBJECT_ID('LOOPP.SP_QuitarFuncDeRol') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_QuitarFuncDeRol
GO

CREATE PROCEDURE [LOOPP].[SP_QuitarFuncDeRol] @idRol int, @idFunc int
AS
	if exists (select 1 from [LOOPP].[Func_X_Rol] where id_rol=@idRol and id_funcionalidad=@idFunc and baja_logica='False')
	begin
		update [LOOPP].[Func_X_Rol]
		set baja_logica = 'True'
		where id_funcionalidad=@idFunc and id_rol=@idRol;
	end
GO

---------------------------------------------------------------------------------------
/* SP_GenerarRendicionComision */

/*Retorna valor de comision por total de compra*/
IF OBJECT_ID('[LOOPP].[Fn_CalcularComision]') IS NOT NULL
    DROP Function [LOOPP].[Fn_CalcularComision]
GO
CREATE FUNCTION [LOOPP].[Fn_CalcularComision] (@Importe_total numeric (18,0), @idPrioridad int)
RETURNS numeric(10,2)
AS 
	BEGIN
		declare @comision numeric(10,2)
		
		select @comision=(@Importe_total*comision)
		from [LOOPP].[Grados_Publicacion]
		where id_grado_publicacion=@idPrioridad
	
		RETURN @comision
	END
GO

/*Generar rendicion de comisiones*/
IF OBJECT_ID('[LOOPP].[SP_GenerarRendicionComision]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GenerarRendicionComision]
GO
create PROCEDURE [LOOPP].[SP_GenerarRendicionComision] @idEmpresa int, @idEspectaculo int, @cantidad int
AS
	BEGIN TRANSACTION [T]

	BEGIN TRY

		select top (@cantidad) *
		into #Temp_Compra
		from [LOOPP].[Compras]
		order by fecha_compra asc

			select distinct esp.id_espectaculo
				  ,emp.id_empresa
				  ,uesp.precio
				  ,[LOOPP].[Fn_CalcularComision](uesp.precio,esp.id_grado_publicacion) comision
				  ,tu.descripcion+' - Fila '+ub.fila+' - Asiento '+cast(ub.asiento as varchar(10)) ubicacion
			into #Temp_Rendicion
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario 
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable 
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Ubicaciones] ub
				on uesp.id_ubicacion=ub.id_ubicacion
			inner join [LOOPP].[Tipo_Ubicacion] tu
				on ub.id_tipo_ubicacion=tu.id_tipo_ubicacion
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join #Temp_Compra comp
				on lv.id_compra=comp.id_compra
			where emp.id_empresa=@idEmpresa
			and esp.id_espectaculo=@idEspectaculo

		
		declare @newId int;
		select @newId=MAX([nro_factura])+1 from [LOOPP].[Facturas];

		insert into [LOOPP].[Facturas]([nro_factura],[id_empresa],[id_espectaculo],[fecha_factura],[total_factura],[total_comision])
		select @newId,id_empresa,id_espectaculo,GETDATE(),SUM(precio),SUM(comision)
		from #Temp_Rendicion
		group by id_empresa,id_espectaculo
		
		insert into [LOOPP].[Item_Factura]([nro_factura],[monto_compra],[monto_comision],[cantidad],[descripcion])
		select @newId,precio,comision,1,ubicacion
		from #Temp_Rendicion

		update LOOPP.Compras
		set facturado = 'True'
		where id_compra in (select id_compra from #Temp_Rendicion)
			
	COMMIT TRANSACTION [T]

	select fa.*,emp.razon_social
	from [LOOPP].[Facturas] fa
	inner join [LOOPP].[Empresas] emp
	on fa.id_empresa=emp.id_empresa
	where nro_factura=@newId;

	drop table #Temp_Rendicion;
	drop table #Temp_Compra;

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  print 'Error: ' + ERROR_MESSAGE();

	END CATCH;
GO
---------------------------------------------------------------------------------------
/*[LOOPP].[SP_GetAllGradosActivos */

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

---------------------------------------------------------------------------------------
/*SP_AllComprasPorEmpEsp */

IF OBJECT_ID('[LOOPP].[SP_AllComprasPorEmpresa]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllComprasPorEmpresa]
GO
CREATE PROCEDURE [LOOPP].[SP_AllComprasPorEmpresa] @idEmpresa int,@idEspectaculo int
AS
BEGIN
	if (@idEspectaculo is not null)
		begin
			select comp.id_compra
				  ,esp.descripcion Espectaculo
				  ,comp.fecha_compra [Fecha Compra]
				  ,comp.importe_total [Importe Total]
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable and esp.id_espectaculo=@idEspectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where comp.facturado='False'
			group by comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total
			order by comp.fecha_compra asc
		end

	else
		begin
			select comp.id_compra
				  ,esp.descripcion Espectaculo
				  ,comp.fecha_compra [Fecha Compra]
				  ,comp.importe_total [Importe Total]
			from [LOOPP].[Empresas] emp
			left join [LOOPP].[Usuarios] usu
				on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
			inner join [LOOPP].[Espectaculos] esp
				on usu.id_usuario=esp.id_usuario_responsable --and esp.id_espectaculo=@idEspectaculo
			inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
				on esp.id_espectaculo=uesp.id_espectaculo
			inner join [LOOPP].[Localidades_Vendidas] lv
				on uesp.id_espectaculo=lv.id_espectaculo
			inner join [LOOPP].[Compras] comp
				on lv.id_compra=comp.id_compra
			where comp.facturado='False'
			group by comp.id_compra,esp.descripcion,comp.fecha_compra,comp.importe_total
			order by comp.fecha_compra asc
		end
END
GO


---------------------------------------------------------------------------------------
/* SP_EmpresasActivas y Espectaculos por Empresa */

/*SP que devuelve todas las empresas activas*/
IF OBJECT_ID('[LOOPP].[SP_AllEmpresasActivas]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllEmpresasActivas]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEmpresasActivas]
AS
BEGIN
	select [id_empresa],[razon_social]
	from [LOOPP].[Empresas]
	where [baja_logica] = 'False'
	order by right(razon_social,2)

END
GO

/*SP que devuelve todos los espectaculos de una empresa*/
IF OBJECT_ID('[LOOPP].[SP_AllEspectaculosPorIdEmpresa]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdEmpresa]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdEmpresa] @idEmpresa int
AS
BEGIN
	select [id_espectaculo],[descripcion]
	from [LOOPP].[Empresas] emp
	inner join [LOOPP].[Usuarios] usu
	on emp.id_usuario=usu.id_usuario and emp.id_empresa=@idEmpresa
	inner join [LOOPP].[Espectaculos] esp
	on usu.id_usuario=esp.id_usuario_responsable
	group by [id_espectaculo],[descripcion]

END
GO


---------------------------------------------------------------------------------------
/* SP_FiltrarEspectaculos para compra */
/*SP que devuelve consulta con compras segun id seleccionadas en la APP*/
IF OBJECT_ID('[LOOPP].[SP_RetornaCategoriasSegunIdList]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_RetornaCategoriasSegunIdList]
GO
CREATE PROCEDURE [LOOPP].[SP_RetornaCategoriasSegunIdList] @idList varchar(100)
AS
BEGIN

	DECLARE @SQL varchar(max)

	SET @SQL = 
			'select *
			from [LOOPP].[Rubros]
			where [id_rubro] IN (' + @idList + ')'

	EXEC(@SQL)	
END
GO

/*Devuelve espectaculos para realizar compra*/
IF OBJECT_ID('[LOOPP].[SP_FiltrarEspectaculos]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_FiltrarEspectaculos]
GO
CREATE PROCEDURE [LOOPP].[SP_FiltrarEspectaculos] @idEspectaculo int, @idList varchar(100), @desde varchar(15), @hasta varchar(15)
AS
BEGIN
	
	if (@idEspectaculo != 0)
	begin

		select esp.id_espectaculo
			  ,esp.descripcion Espectaculo
			  ,esp.fecha_espectaculo [Fecha Espectaculo]
			  ,esp.hora_espectaculo [Horarios]
		from [LOOPP].[Espectaculos] esp
		inner join [LOOPP].[Estados_Publicacion] estado
			on esp.id_estado_publicacion=estado.id_estado_publicacion and estado.descripcion='Publicada'
		inner join [LOOPP].[Grados_Publicacion] grado
			on esp.id_grado_publicacion=grado.id_grado_publicacion
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		where esp.id_espectaculo=@idEspectaculo 
		and esp.fecha_espectaculo between cast(@desde as date) and cast(@hasta as date)
		group by esp.id_espectaculo,esp.descripcion,grado.id_grado_publicacion,esp.fecha_espectaculo,esp.hora_espectaculo
		order by grado.id_grado_publicacion
	end

	if (@idEspectaculo = 0 and @idList is not null)
	begin

		/*Genero tabla temporal con los registros obtenidos*/
		CREATE TABLE #Temp_Rubros (	[id_rubro] int NOT NULL,
									[descripcion] varchar(20) NOT NULL)

		insert into #Temp_Rubros ([id_rubro],[descripcion]) 
		exec [LOOPP].[SP_RetornaCategoriasSegunIdList] @idList;

		select esp.id_espectaculo
			  ,esp.descripcion Espectaculo
			  ,esp.fecha_espectaculo [Fecha Espectaculo]
			  ,esp.hora_espectaculo [Horarios]
		from [LOOPP].[Espectaculos] esp
		inner join #Temp_Rubros rubros
		on esp.id_rubro=rubros.id_rubro
		inner join [LOOPP].[Estados_Publicacion] estado
			on esp.id_estado_publicacion=estado.id_estado_publicacion and estado.descripcion='Publicada'
		inner join [LOOPP].[Grados_Publicacion] grado
			on esp.id_grado_publicacion=grado.id_grado_publicacion
		inner join [LOOPP].[Ubicac_X_Espectaculo] uesp
			on esp.id_espectaculo=uesp.id_espectaculo
		where esp.fecha_espectaculo between cast(@desde as date) and cast(@hasta as date)
		group by esp.id_espectaculo,esp.descripcion,grado.id_grado_publicacion,esp.fecha_espectaculo,esp.hora_espectaculo
		order by grado.id_grado_publicacion
	end
END
GO
---------------------------------------------------------------------------------------
/*Historial de compras del cliente*/

IF OBJECT_ID('[LOOPP].[SP_HistorialComprasCliente]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_HistorialComprasCliente]
GO
CREATE PROCEDURE [LOOPP].[SP_HistorialComprasCliente] @idUsuario int
AS
	select	comp.fecha_compra [Fecha Compra], 
			esp.descripcion [Espectaculo], 
			esp.fecha_espectaculo [Fecha Espectaculo], 
			comp.importe_total [Importe Total], 
			fp.descripcion [Forma de Pago], 
			ub.fila [Fila], 
			ub.asiento [Asiento]
	from LOOPP.Compras comp
	inner join LOOPP.Clientes cli on cli.id_cliente=comp.id_cliente
	inner join LOOPP.Localidades_Vendidas lcv on lcv.id_compra=comp.id_compra
	inner join LOOPP.Espectaculos esp on esp.id_espectaculo=lcv.id_espectaculo
	inner join LOOPP.Ubicaciones ub on lcv.id_ubicacion=ub.id_ubicacion
	inner join LOOPP.Formas_Pago_Cliente fpc on fpc.id_forma_pago_cliente=comp.id_forma_pago_cliente
	inner join LOOPP.Formas_Pago fp on fp.id_forma_pago = fpc.id_forma_pago
	where id_usuario=@idUsuario
	group by comp.id_compra, comp.fecha_compra, esp.descripcion, esp.fecha_espectaculo, comp.importe_total,fp.descripcion, ub.fila, ub.asiento

	order by comp.id_compra
GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllEstadosPublicacion */
IF OBJECT_ID('LOOPP.SP_GetAllEstadosPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllEstadosPublicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllEstadosPublicacion
AS
	SELECT * from LOOPP.Estados_Publicacion
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_GetAllUbicaciones */

IF OBJECT_ID('LOOPP.SP_GetAllUbicaciones') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllUbicaciones
GO
CREATE PROCEDURE LOOPP.SP_GetAllUbicaciones
AS
	SELECT id_ubicacion, T_U.descripcion + '-' +fila+LTRIM(RTRIM(STR(asiento))) as descripcion, fila, asiento, sin_numerar, u.id_tipo_ubicacion
	 from LOOPP.Ubicaciones U
	 INNER JOIN Tipo_Ubicacion T_U on T_U.id_tipo_ubicacion=U.id_tipo_ubicacion
GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllGradosPublicacion */

IF OBJECT_ID('LOOPP.SP_GetAllGradosPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllGradosPublicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllGradosPublicacion
AS
	SELECT * from LOOPP.Grados_Publicacion
GO
---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllRubros */

IF OBJECT_ID('LOOPP.SP_GetAllRubros') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllRubros
GO
CREATE PROCEDURE LOOPP.SP_GetAllRubros
AS
	SELECT * from LOOPP.Rubros
GO
---------------------------------------------------------------------------------------
/*LOOPP.Fn_CalcularPuntos */

IF OBJECT_ID('LOOPP.Fn_CalcularPuntos') IS NOT NULL
    DROP FUNCTION LOOPP.Fn_CalcularPuntos
GO

CREATE FUNCTION [LOOPP].[Fn_CalcularPuntos] (@Importe_total numeric (18,0))
RETURNS int
AS BEGIN
		declare @puntos int
	set @puntos = ( @Importe_total /10)
	
    RETURN @puntos
END
GO

---------------------------------------------------------------------------------------
/*LOOPP.SP_NuevoIntentoFallido */

IF OBJECT_ID('LOOPP.SP_NuevoIntentoFallido') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_NuevoIntentoFallido
GO
CREATE PROCEDURE LOOPP.SP_NuevoIntentoFallido
	@id_user int
AS
BEGIN
	UPDATE LOOPP.Usuarios
	SET loginFallidos= loginFallidos + 1 
	WHERE id_usuario=@id_user
END
GO


---------------------------------------------------------------------------------------
/* LOOPP.SP_ReiniciarIntentosLogin */

IF OBJECT_ID('LOOPP.SP_ReiniciarIntentosLogin', 'P') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ReiniciarIntentosLogin
GO

CREATE PROCEDURE LOOPP.SP_ReiniciarIntentosLogin 
	@id_user int
AS
BEGIN
	UPDATE LOOPP.Usuarios  
	SET loginFallidos = '0' 
	WHERE id_usuario = @id_user;  
END

GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_CambiarPassword */

IF OBJECT_ID('LOOPP.SP_CambiarPassword') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_CambiarPassword
GO
CREATE PROCEDURE LOOPP.SP_CambiarPassword
	@newPass varchar(255),
	@id_usuario int
	
AS
BEGIN
	declare @esPrimerLogueo bit
	SELECT @esPrimerLogueo=primerLoginAuto
	FROM LOOPP.Usuarios
	WHERE id_usuario = @id_usuario
	if (@esPrimerLogueo='True')
		begin
			UPDATE LOOPP.Usuarios 
				SET password=@newPass,
					primerLoginAuto='False'
				WHERE id_usuario=@id_usuario
		end
	else
		begin
			UPDATE LOOPP.Usuarios
			SET password=@newPass
			WHERE id_usuario=@id_usuario
	end
END
GO

---------------------------------------------------------------------------------------
/* LOOPP.SP_GetAllTiposUbicacion */

IF OBJECT_ID('LOOPP.SP_GetAllTiposUbicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetAllTiposUbicacion
GO
CREATE PROCEDURE LOOPP.SP_GetAllTiposUbicacion
AS
	SELECT *
	 from LOOPP.Tipo_Ubicacion
GO
--------------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.[SP_AllEspectaculosPorIdUsuario]') IS NOT NULL
    DROP PROCEDURE LOOPP.[SP_AllEspectaculosPorIdUsuario]
GO
CREATE PROCEDURE [LOOPP].[SP_AllEspectaculosPorIdUsuario] @idUsuario int
AS
BEGIN
	select [id_espectaculo],esp.[descripcion] as 'Descripcion' ,fecha_publicacion as 'Fecha de publicacion', fecha_espectaculo as 'Fecha de espectaculo', hora_espectaculo as 'Horario de espectaculo', direccion as 'Direccion', estP.descripcion as 'Estado Publicacion'
	from Espectaculos esp
	inner join LOOPP.Estados_Publicacion estP on estP.id_estado_publicacion=esp.id_estado_publicacion
	where esp.id_usuario_responsable=@idUsuario
	group by [id_espectaculo],esp.[descripcion], fecha_publicacion, direccion, estP.descripcion, fecha_espectaculo, hora_espectaculo
	
END

GO

---------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetEspectaculoFiltradoPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEspectaculoFiltradoPorId
GO

CREATE PROCEDURE [LOOPP].[SP_GetEspectaculoFiltradoPorId] @idEspectaculo int
AS
BEGIN
	select [id_espectaculo],esp.[descripcion] as 'Descripcion' ,fecha_publicacion as 'Fecha de publicacion', fecha_espectaculo as 'Fecha de espectaculo', hora_espectaculo as 'Horario de espectaculo', direccion as 'Direccion', estP.descripcion as 'Estado Publicacion'
	from Espectaculos esp
	inner join LOOPP.Estados_Publicacion estP on estP.id_estado_publicacion=esp.id_estado_publicacion
	where id_espectaculo = @idEspectaculo
	group by [id_espectaculo],esp.[descripcion], fecha_publicacion, direccion, estP.descripcion, fecha_espectaculo, hora_espectaculo
END

GO
-------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetEspectaculoPorId') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetEspectaculoPorId
GO

CREATE PROCEDURE [LOOPP].[SP_GetEspectaculoPorId] @idEspectaculo int
AS
BEGIN
	select * from LOOPP.Espectaculos
	where id_espectaculo = @idEspectaculo
END

GO

---------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetUbicacionesEspectaculo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetUbicacionesEspectaculo
GO

CREATE PROCEDURE [LOOPP].[SP_GetUbicacionesEspectaculo] @id_espectaculo int
AS
BEGIN
	select u.id_ubicacion, T_U.descripcion + '-' +fila+LTRIM(RTRIM(STR(asiento))) as descripcion, fila, asiento, sin_numerar, u.id_tipo_ubicacion
	from LOOPP.Ubicaciones u
	INNER JOIN Tipo_Ubicacion T_U on T_U.id_tipo_ubicacion=U.id_tipo_ubicacion
	inner join Ubicac_X_Espectaculo uxe on uxe.id_espectaculo=@id_espectaculo and uxe.id_ubicacion=u.id_ubicacion

END

GO

-----------------------------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_ModificarPublicacion') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_ModificarPublicacion
GO
USE [GD2C2018]
GO

CREATE PROCEDURE [LOOPP].[SP_ModificarPublicacion]
	@descripcion nvarchar(255),
	@direccion nvarchar(255)
   ,@id_grado_publicacion int
   ,@id_estado int
   ,@rubro int
   ,@precio_base numeric(18,0)
   ,@fechaEspec date
   ,@horaEspec varchar(255)
   ,@id_espectaculo int
  AS
	declare @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
		IF EXISTS (
			SELECT 1 
			FROM LOOPP.Espectaculos  
			WHERE descripcion=@descripcion and direccion=@direccion and id_espectaculo= @id_espectaculo and hora_espectaculo= CONVERT(time,@horaEspec) and fecha_espectaculo = @fechaEspec)
		BEGIN
			RAISERROR('Existe un mismo espectaculo con la misma fecha y hora. Ingrese otro horario y/o fecha ',16,1)
		END

		UPDATE LOOPP.Espectaculos
		SET 
			descripcion=@descripcion,
			direccion=@direccion,
			id_grado_publicacion=@id_grado_publicacion,
			id_estado_publicacion=@id_estado,
			id_rubro=@rubro,
			precio_base=@precio_base,
			fecha_espectaculo=@fechaEspec,
			hora_espectaculo=@horaEspec
		WHERE id_espectaculo=@id_espectaculo

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
GO

---------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_BloquearUsuario') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_BloquearUsuario
GO

CREATE PROCEDURE [LOOPP].[SP_BloquearUsuario] @id_usuario int
AS
BEGIN
	UPDATE LOOPP.Usuarios
	SET habilitado='False'
	where id_usuario=@id_usuario
END

GO
------------------------------------------------------------------
/*Retorna medio de pagos validos*/


IF OBJECT_ID('LOOPP.SP_GetFormasPagoValidas') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetFormasPagoValidas
GO

CREATE PROCEDURE [LOOPP].[SP_GetFormasPagoValidas] 
AS
	select *
	from [LOOPP].[Formas_Pago] 
	where descripcion != 'Efectivo'
GO

-------------------------------------------------------------------
/*Retorna los Medios de pago por cliente*/
IF OBJECT_ID('LOOPP.SP_GetMedioPagoXCliente') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetMedioPagoXCliente
GO

CREATE PROCEDURE [LOOPP].[SP_GetMedioPagoXCliente] @idCliente int
AS
	select *
	from [LOOPP].[Formas_Pago_Cliente] fpc
	inner join LOOPP.Formas_Pago fp on fp.id_forma_pago=fpc.id_forma_pago
	where id_cliente=@idCliente 
	and fp.descripcion != 'Efectivo'
GO
---------------------------------------------------------------------

/*Inserta medio de pago asociado para un cliente */
IF OBJECT_ID('LOOPP.SP_InsertarMedioPago') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_InsertarMedioPago
GO

CREATE PROCEDURE [LOOPP].[SP_InsertarMedioPago] @idCliente int,@idFormaPago int, @nro bigint
AS
	declare @resultado varchar(55);

	if not exists (select 1 from [LOOPP].[Formas_Pago_Cliente]
				   where [nro_tarjeta]=@nro)
		begin

			insert into [LOOPP].[Formas_Pago_Cliente]([id_cliente], [id_forma_pago], [nro_tarjeta])
			values (@idCliente, @idFormaPago, @nro)

			set @resultado = 'OK'
		end
	else set @resultado = 'ERROR. No pudo agregarse el medio de pago porque ya existe en el sistema.'

	select @resultado;
GO

------------------------------------------------------------------------------

/*Elimina medio de pago asociado para un cliente */
IF OBJECT_ID('LOOPP.SP_EliminarMedioPagoCliente') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_EliminarMedioPagoCliente
GO

CREATE PROCEDURE [LOOPP].[SP_EliminarMedioPagoCliente] @idFormaPagoCliente int
AS
	declare @resultado varchar(55);
	BEGIN TRANSACTION [T]

	BEGIN TRY
		DELETE LOOPP.Formas_Pago_Cliente
		WHERE id_forma_pago_cliente=@idFormaPagoCliente

	
	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = 'No pudo agregarse el medio de pago: '+ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
GO


--------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_GetCatalogo') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetCatalogo
GO

CREATE PROCEDURE [LOOPP].[SP_GetCatalogo]
AS
BEGIN
	select id_codigo, stock as 'Stock', descripcion as 'Descripcion', puntos_validos as 'Puntos necesarios'
	from LOOPP.Catalogo_Canjes
END

GO
--------------------------------------------------------------------------------

/*SP que modifica descripcion de rol cuando el rol esta activo, en caso de estar de baja retorna error*/
IF OBJECT_ID('[LOOPP].[SP_ModificarDescRol]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_ModificarDescRol]
GO
CREATE PROCEDURE [LOOPP].[SP_ModificarDescRol] @id int,@descripcion varchar(50)
AS
	declare @resultado varchar(10);

	if not exists (select 1 from [LOOPP].[Roles] where id_rol=@id and baja_logica = 1)
	begin
		update [LOOPP].[Roles]
		set [nombre]= @descripcion
		where id_rol=@id
		and baja_logica != 1

		set @resultado = 'OK'
	end
	else set @resultado='ERROR'
	
	select @resultado; 

GO
--------------------------------------------------------------------------------

/*SP que devuelve tipos de ubicacion disponible segun espectaculo*/
IF OBJECT_ID('[LOOPP].[SP_GetTipoUbicXEspect]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GetTipoUbicXEspect]
GO
CREATE PROCEDURE [LOOPP].[SP_GetTipoUbicXEspect] @id int,@fecha varchar(15),@hora varchar(15)
AS
	select distinct tu.*
	from [LOOPP].[Ubicac_X_Espectaculo] ue
	inner join [LOOPP].[Espectaculos] e
	on ue.id_espectaculo=e.id_espectaculo
	inner join [LOOPP].[Ubicaciones] u
	on ue.id_ubicacion=u.id_ubicacion
	inner join [LOOPP].[Tipo_Ubicacion] tu
	on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
	where e.id_espectaculo=@id 
	and e.fecha_espectaculo=cast(@fecha as date)
	and e.hora_espectaculo=cast(@hora as time)
	and ue.disponible = 1

GO
--------------------------------------------------------------------------------

/*SP que devuelve las ubicaciones segun espectaculo y tipo de ubicacion seleccionado*/
IF OBJECT_ID('[LOOPP].[SP_GetUbicacionesXEspec]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_GetUbicacionesXEspec]
GO
CREATE PROCEDURE [LOOPP].[SP_GetUbicacionesXEspec] @id int,@fecha varchar(15),@hora varchar(15),@idTipoUbic int
AS
	select distinct u.id_ubicacion
		  ,'Fila '+[fila]+' - Asiento '+cast([asiento] as varchar(10))+
		  ' - Costo '+cast(ue.precio as varchar(10)) Ubicacion
	from [LOOPP].[Ubicac_X_Espectaculo] ue
	inner join [LOOPP].[Espectaculos] e
		on ue.id_espectaculo=e.id_espectaculo
	inner join [LOOPP].[Ubicaciones] u
		on ue.id_ubicacion=u.id_ubicacion
	inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
	where e.id_espectaculo=@id 
	and e.fecha_espectaculo=cast(@fecha as date)
	and e.hora_espectaculo=cast(@hora as time)
	and ue.disponible = 1
	and tu.id_tipo_ubicacion=@idTipoUbic

GO
----------------------------------------------------

IF OBJECT_ID('LOOPP.SP_GetHistorialCanje') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetHistorialCanje
GO

CREATE PROCEDURE [LOOPP].[SP_GetHistorialCanje] @idUsuario int
AS
BEGIN
	select can.id_canje as 'Codigo', fecha_canje as 'Fecha de Canje', cli.nombre+' '+cli.apellido as 'Responsable', cc.descripcion as 'Producto Canjeado', can.puntos_canjeados as 'Puntos canjeados'
	from LOOPP.Canjes can
	inner join Clientes cli on cli.id_cliente=can.id_cliente 
	inner join Catalogo_Canjes cc on cc.id_codigo=can.id_codigo
	where cli.id_usuario= @idUsuario
END

GO
--------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_EsUsuarioHabilitado') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_EsUsuarioHabilitado
GO

CREATE PROCEDURE [LOOPP].[SP_EsUsuarioHabilitado] @id_cliente int
AS
BEGIN
	select habilitado
	from LOOPP.Usuarios usu
	inner join Clientes cli on cli.id_usuario=usu.id_usuario
	where cli.id_cliente=@id_cliente
END

GO

--------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
/*SP que devuelve consulta con compras segun id seleccionadas en la APP*/
IF OBJECT_ID('[LOOPP].[SP_RetornaUbicacionesDeLista]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_RetornaUbicacionesDeLista]
GO
CREATE PROCEDURE [LOOPP].[SP_RetornaUbicacionesDeLista] @idUbicaciones varchar(30)
AS
BEGIN

	DECLARE @SQL varchar(max)

	SET @SQL = 
			'select [id_ubicacion],[id_tipo_ubicacion]
			from [LOOPP].[Ubicaciones]
			where [id_ubicacion] IN (' + @idUbicaciones + ')'

	EXEC(@SQL)	
END
GO
/*SP que inserta la compra de ubicacion*/
IF OBJECT_ID('[LOOPP].[SP_ComprarEspectaculo]') IS NOT NULL
    DROP PROCEDURE [LOOPP].[SP_ComprarEspectaculo]
GO
CREATE PROCEDURE [LOOPP].[SP_ComprarEspectaculo] @idCliente int,@idEspec int, @idUbicaciones varchar(30), @idFormaPago int
AS
declare @resultado varchar(255)
	BEGIN TRANSACTION [T]

	BEGIN TRY
	/*Genero tabla temporal con los registros obtenidos*/
	CREATE TABLE #Temp_Ubicaciones ([id_ubicacion] int NOT NULL,[id_tipo_ubicacion] int NOT NULL)

	insert into #Temp_Ubicaciones ([id_ubicacion],[id_tipo_ubicacion]) 
	exec [LOOPP].[SP_RetornaUbicacionesDeLista] @idUbicaciones

	--Inserta compras
	insert into [LOOPP].[Compras]([fecha_compra]
								 ,[importe_total]
								 ,[cantidad_compra]
								 ,[id_forma_pago_cliente]
								 ,[puntos]
								 ,[id_cliente]
								 )
	select GETDATE()
		  ,SUM(ue.precio)
		  ,COUNT(1)
		  ,@idFormaPago
		  ,[LOOPP].[Fn_CalcularPuntos](SUM(ue.precio))
		  ,@idCliente
	from #Temp_Ubicaciones u
	inner join [LOOPP].[Ubicac_X_Espectaculo] ue
		on u.id_ubicacion=ue.id_ubicacion
	inner join [LOOPP].[Espectaculos] e
		on ue.id_espectaculo=e.id_espectaculo
	inner join [LOOPP].[Tipo_Ubicacion] tu
		on u.id_tipo_ubicacion=tu.id_tipo_ubicacion
	where e.id_espectaculo=@idEspec 
	and tu.id_tipo_ubicacion=u.id_tipo_ubicacion

	--Inserta Localidades

	declare @idCompra int;
	select @idCompra=MAX(id_compra) from [LOOPP].[Compras]

	insert into [LOOPP].[Localidades_Vendidas]([id_compra],[id_espectaculo],[id_ubicacion])
	select @idCompra,@idEspec,id_ubicacion
	from #Temp_Ubicaciones

	update [LOOPP].[Ubicac_X_Espectaculo]
	set [disponible]='False'
	where id_ubicacion in (select id_ubicacion from #Temp_Ubicaciones)
	and id_espectaculo=@idEspec;

	COMMIT TRANSACTION [T]

	set @resultado = 'OK';

	Drop table #Temp_Ubicaciones;

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado = ERROR_MESSAGE();

	END CATCH;
	
	SELECT @resultado
GO	
-------------------------------------------------------------------------------------

IF OBJECT_ID('LOOPP.SP_GetMayorAnioActividad') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetMayorAnioActividad
GO
CREATE PROCEDURE LOOPP.SP_GetMayorAnioActividad
AS
	SELECT TOP 1 (YEAR(comp.fecha_compra)) AÑO
	FROM LOOPP.Compras comp
	ORDER BY comp.fecha_compra DESC
GO


IF OBJECT_ID('LOOPP.SP_GetMenorAnioActividad') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetMenorAnioActividad
GO
CREATE PROCEDURE LOOPP.SP_GetMenorAnioActividad
AS
	SELECT TOP 1 (YEAR(comp.fecha_compra)) AÑO
	FROM LOOPP.Compras comp
	ORDER BY comp.fecha_compra ASC
GO

------------------------------------------------

----------------------------------------------------------------------<----------
IF OBJECT_ID('LOOPP.SP_GetPuntosClienteConIdUsuario') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_GetPuntosClienteConIdUsuario
GO

CREATE PROCEDURE [LOOPP].[SP_GetPuntosClienteConIdUsuario] @idUsuario int , @fechaActual datetime
AS
BEGIN
	
	select sum(com.puntos-regP.puntos_usados)
	from LOOPP.Compras com 
	inner join LOOPP.Clientes cli on cli.id_cliente=com.id_cliente
	inner join LOOPP.Registro_Puntos regP on regP.id_compra=com.id_compra and cli.id_cliente=regP.id_cliente
	where cli.id_usuario=@idUsuario and fecha_vencimiento>@fechaActual
	group by cli.id_cliente
	
END

GO

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
IF OBJECT_ID('LOOPP.SP_CanjearProducto') IS NOT NULL
    DROP PROCEDURE LOOPP.SP_CanjearProducto
GO

CREATE PROCEDURE [LOOPP].[SP_CanjearProducto] @idProducto int, @idUsuario int, @fechaCanje datetime
AS
BEGIN
	DECLARE @puntosACanjear int, @idCanje int, @idCliente int, @resultado varchar(255), @idCompra int, @puntosDisponibles int, @puntosProducto int
	BEGIN TRANSACTION [T]

	BEGIN TRY

		
		SELECT @puntosProducto=puntos_validos
		FROM LOOPP.Catalogo_Canjes
		WHERE id_codigo=@idProducto

		SELECT id_cliente
		into #Temp_Cliente_Consulta
		from LOOPP.Clientes
		where id_usuario=@idUsuario

		DECLARE db_cursor CURSOR FOR 
			select rp.id_cliente ,rp.id_compra, com.puntos-rp.puntos_usados
			from LOOPP.Registro_Puntos rp
			inner join LOOPP.Compras com on com.id_compra=rp.id_compra
			inner join #Temp_Cliente_Consulta temp on temp.id_cliente=com.id_cliente
			where com.puntos-rp.puntos_usados>0
			group by rp.id_compra,  rp.id_cliente,com.puntos ,fecha_compra, rp.puntos_usados
			order by fecha_compra asc
		OPEN db_cursor  
		FETCH NEXT FROM db_cursor INTO @idCliente, @idCompra, @puntosDisponibles
		SET @puntosACanjear= @puntosProducto
		WHILE @@FETCH_STATUS = 0 or @puntosACanjear>0
		BEGIN
			
			IF (@puntosACanjear>=@puntosDisponibles)
				BEGIN
					SET @puntosACanjear=@puntosACanjear - @puntosDisponibles
					UPDATE LOOPP.Registro_Puntos
						SET puntos_usados=puntos_usados+@puntosDisponibles
					where id_compra=@idCompra and id_cliente=@idCliente
				END
			ELSE
				BEGIN
					UPDATE LOOPP.Registro_Puntos
						SET puntos_usados=puntos_usados+@puntosACanjear
					where id_compra=@idCompra and id_cliente=@idCliente
					SET @puntosACanjear=0
					BREAK;
				END
			
			
			FETCH NEXT FROM db_cursor INTO @idCliente, @idCompra, @puntosDisponibles
		END 

		CLOSE db_cursor  
		DEALLOCATE db_cursor	
		
		drop table #Temp_Cliente_Consulta
		UPDATE LOOPP.Catalogo_Canjes
			SET stock = stock - 1
		WHERE id_codigo = @idProducto

		INSERT INTO LOOPP.Canjes(fecha_canje, puntos_canjeados, id_codigo, id_cliente)
		VALUES (@fechaCanje, @puntosProducto, @idProducto, @idCliente)
		
		SELECT @idCanje=SCOPE_IDENTITY() 
		FROM LOOPP.Canjes

	COMMIT TRANSACTION [T]

	set @resultado = 'OK;'+CONVERT(varchar(255),@idCanje)

	END TRY

	BEGIN CATCH

      ROLLBACK TRANSACTION [T]

	  set @resultado ='ERROR;' +ERROR_MESSAGE();

	END CATCH;
	SELECT @resultado
END

GO