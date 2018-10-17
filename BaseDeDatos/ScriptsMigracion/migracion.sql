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

/*Creacion de Rubros*/

INSERT INTO LOOPP.Rubros (descripcion) VALUES ('No definido');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Musical');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Obra Teatral');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Humoristico');
INSERT INTO LOOPP.Rubros (descripcion) VALUES ('Audio Visual');

/*Grados de Publicacion*/
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision,descripcion) VALUES (1,0.30,'Alta');
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision, descripcion) VALUES ( 2, 0.25, 'Media');
INSERT INTO LOOPP.Grados_Publicacion (prioridad, comision, descripcion) VALUES ( 3, 0.10, 'Baja');

/*Creacion de Roles*/

INSERT INTO [LOOPP].[Roles]([nombre]) VALUES ('Administrativo');
INSERT INTO [LOOPP].[Roles]([nombre]) VALUES ('Cliente');
INSERT INTO [LOOPP].[Roles]([nombre]) VALUES ('Empresa');

/*Creacion de usuario Admin*/
INSERT INTO [LOOPP].[Usuarios] (username,password,estado)
--user :admin pass: w23e
VALUES ('admin', '52d77462b24987175c8d7dab901a5967e927ffc8d0b6e4a234e07a4aec5e3724','Habilitado');

/*Creacion de Rol_X_Usuario para el admin*/
INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) VALUES (1,1);
INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) VALUES (1,2);
INSERT INTO [LOOPP].[Rol_X_Usuario] (id_usuario,id_rol) VALUES (1,3);

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
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Canje Puntos'); --10 
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('Listado Estadistico');  --11
INSERT INTO [LOOPP].[Funcionalidades] (nombre) VALUES ('ABM Grado Publicacion');  --12


/*Creacion de Funcionalidad_X_Rol*/
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,1);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,2);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,3);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,8);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,11);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (1,12);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,4);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,5);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,9);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (2,10);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (3,6);
INSERT INTO [LOOPP].[Func_X_Rol] (id_rol,id_funcionalidad) VALUES (3,7);

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
