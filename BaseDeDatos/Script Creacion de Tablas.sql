USE [GD2C2018]
GO

IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'LOOPP')) 
BEGIN
    EXEC ('CREATE SCHEMA [LOOPP]')
END

/*BORRADO DE ENTIDADES*/

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
	

/*##########################################################################################################*/
/*										CREACION DE TABLAS													*/
/*##########################################################################################################*/
Print '***Inicio de creacion de tablas***'
	/*-1- Tabla Roles*/
	CREATE TABLE [LOOPP].[Roles](	
		[id_rol] int IDENTITY(1,1) NOT NULL,
		[nombre] varchar (50) NOT NULL,
		[estado] bit NOT NULL DEFAULT('True'),
		primary key ([id_rol])
	);

	/*-2- Tabla Funcionalidades*/
	CREATE TABLE [LOOPP].[Funcionalidades](
		id_funcionalidad int IDENTITY(1,1) NOT NULL,
		nombre varchar(30) NOT NULL,
		primary key ([id_funcionalidad])
	);

	/*-3- Tabla Funcionalidad por Rol*/
	CREATE TABLE [LOOPP].[Func_X_Rol](
		[id_funcionalidad] [int] NOT NULL,
		[id_rol] [int] NOT NULL,
		[baja] bit NOT NULL DEFAULT('True'),
		PRIMARY KEY ( [id_funcionalidad], [id_rol]),
		foreign key ([id_funcionalidad]) references [LOOPP].[Funcionalidades]([id_funcionalidad]),
		foreign key ([id_rol]) references [LOOPP].[Roles]([id_rol])
	);
	
	/*-4- Tabla Usuarios*/
	CREATE TABLE [LOOPP].[Usuarios](
		[id_usuario] [int] IDENTITY(1,1) NOT NULL,
		[username] [varchar](255) NOT NULL,
		[password] [varchar](255) NOT NULL,
		[loginFallidos] int NOT NULL DEFAULT (0),
		[habilitado] bit NOT NULL DEFAULT('True'),
		primary key ([id_usuario])
	);

	/*-5- Tabla Rol por Usuario*/
	CREATE TABLE [LOOPP].[Rol_X_Usuario](
		[id_usuario] [int] NOT NULL,
		[id_rol] [int] NOT NULL,
		[activo] bit NOT NULL DEFAULT('True'),
		PRIMARY KEY ( [id_usuario], [id_rol]),
		foreign key ([id_usuario]) references [LOOPP].[Usuarios]([id_usuario]),
		foreign key ([id_rol]) references [LOOPP].[Roles]([id_rol])
	);

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
		primary key ([id_empresa]),
		foreign key ([id_usuario]) references [LOOPP].[Usuarios]([id_usuario])
	);

	/*-7- Tabla Estados de Publicacion*/
	CREATE TABLE LOOPP.Estados_Publicacion(
		id_estado_publicacion int identity(1,1) NOT NULL,
		descripcion nvarchar(255) NOT NULL,
		primary key ([id_estado_publicacion])
	);

	/*-8- Tabla Grados de Publicacion*/
	CREATE TABLE LOOPP.Grados_Publicacion(
		id_grado_publicacion int identity(1,1) NOT NULL,
		activo bit NOT NULL DEFAULT('True'),
		comision numeric(10,2) NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		primary key ([id_grado_publicacion])
	);

	/*-9- Tabla Rubros*/
	CREATE TABLE LOOPP.Rubros(
		id_rubro int identity(1,1) NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		primary key ([id_rubro])
	);

	/*-10- Tabla Espectaculos*/
	CREATE TABLE LOOPP.Espectaculos(
		id_espectaculo int NOT NULL,
		id_usuario_responsable int not null,
		id_rubro int not null,
		fecha_publicacion datetime NOT NULL,
		descripcion nvarchar(255) NOT NULL,
		direccion nvarchar(50) NULL,
		id_estado_publicacion int not null,
		id_grado_publicacion int not null,
		precio_base numeric(18,2) NOT null DEFAULT(0.00),
		primary key ([id_espectaculo]),
		foreign key ([id_usuario_responsable]) references [LOOPP].[Usuarios]([id_usuario]),
		foreign key ([id_rubro]) references [LOOPP].[Rubros]([id_rubro]),
		foreign key ([id_estado_publicacion]) references [LOOPP].[Estados_Publicacion]([id_estado_publicacion]),
		foreign key ([id_grado_publicacion]) references [LOOPP].[Grados_Publicacion]([id_grado_publicacion])
	);

	/*-11- Tabla Tipo de Ubicacion*/
	CREATE TABLE LOOPP.Tipo_Ubicacion(
		id_tipo_ubicacion int  NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		porcentual numeric(10,2) NOT null,
		primary key ([id_tipo_ubicacion])
	);

	/*-12- Tabla Ubicaciones*/
	CREATE TABLE LOOPP.Ubicaciones(
		id_ubicacion int identity(1,1) NOT NULL,
		fila varchar(3) NOT NULL,
		asiento numeric(18, 0) NOT NULL,
		sin_numerar bit NULL DEFAULT('False'),
		id_tipo_ubicacion int not null,
		primary key ([id_ubicacion]),
		foreign key ([id_tipo_ubicacion]) references [LOOPP].[Tipo_Ubicacion]([id_tipo_ubicacion])
	);

	/*-13- Tabla Ubicacion por espectaculo*/
	CREATE TABLE [LOOPP].[Ubicac_X_Espectaculo](
		[id_espectaculo] [int] NOT NULL,
		[id_ubicacion] [int] NOT NULL,
		[precio] numeric(18,2) NOT null,
		[fecha_espectaculo] date not null,
		[fecha_venc_espectaculo] date not null,
		[hora_espectaculo] time not null,
		[disponible] bit not null DEFAULT('True'),
		PRIMARY KEY ([id_espectaculo], [id_ubicacion]),
		foreign key ([id_espectaculo]) references [LOOPP].[Espectaculos]([id_espectaculo]),
		foreign key ([id_ubicacion]) references [LOOPP].[Ubicaciones]([id_ubicacion])
	);

	/*-14- Tabla Clientes*/
	CREATE TABLE LOOPP.Clientes(
		id_cliente int identity(1,1) NOT NULL,
		estado nvarchar(50) NOT NULL DEFAULT('Habilitado'),
		baja_logica bit DEFAULT ('False'),
		puntos_acumulados int NOT NULL DEFAULT('0'),
		fecha_vencimiento date null,
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
		primary key ([id_cliente]),
		foreign key ([id_usuario]) references [LOOPP].[Usuarios]([id_usuario])
	);


	/*-15- Formas de Pago Cliente*/
	CREATE TABLE LOOPP.Formas_Pago_Cliente(
		id_forma_pago_cliente int identity(1,1) NOT NULL,
		descripcion nvarchar(20) NOT NULL,
		nro_tarjeta bigint,
		marca nvarchar(20),
		id_cliente int NOT NULL,
		primary key ([id_forma_pago_cliente]),
		foreign key (id_cliente) references [LOOPP].[Clientes](id_cliente)
	);
	
	/*-16- Catalogo de canjes*/
	CREATE TABLE LOOPP.Catalogo_Canjes(
		id_codigo int identity(1,1) NOT NULL,
		stock numeric(18, 0) not null,
		descripcion	nvarchar(30) NOT NULL,
		puntos_validos numeric(18, 0) not NULL,
		primary key ([id_codigo])
	);

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
	);

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
		
	);

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
	);

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
	);


	/*-21- Tabla Localidades vendidas*/
	CREATE TABLE LOOPP.Localidades_Vendidas(
		id_compra int NOT NULL,
		id_espectaculo int NOT NULL,
		id_ubicacion int NOT NULL,
		primary key (id_compra,id_espectaculo,id_ubicacion),
		foreign key (id_compra) references [LOOPP].[Compras](id_compra),
		foreign key (id_espectaculo) references [LOOPP].[Espectaculos](id_espectaculo),
		foreign key (id_ubicacion) references [LOOPP].[Ubicaciones](id_ubicacion)
	);

Print '***Fin de creacion de tablas***'