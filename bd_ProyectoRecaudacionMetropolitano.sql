---------BD PARA SISTEMA DE RECAUDACION METROPOLITANO:TARJETAS VIRTUALES---

USE master;
GO

IF EXISTS(SELECT name From master.sys.databases WHERE name ='DB_TarjetasMetropolitano')
BEGIN
	DROP DATABASE DB_TarjetasMetropolitano
END
GO

CREATE DATABASE DB_TarjetasMetropolitano
GO

USE DB_TarjetasMetropolitano
GO

CREATE TABLE USUARIO(
idUsuario INT IDENTITY PRIMARY KEY,
nombreUsuario VARCHAR(100),
contraseņa VARCHAR(50)
)
GO

CREATE TABLE ESTADOS_ENTIDADES(
idEstado INT IDENTITY PRIMARY KEY,
tipoEstado VARCHAR(50)
)
GO

CREATE TABLE TIPO_TARJETA(
idTipoTarjeta INT IDENTITY PRIMARY KEY,
nombreTipo VARCHAR(60),
fechaVencimiento DATETIME
)
GO

CREATE TABLE TARJETA(
idTarjeta INT IDENTITY PRIMARY KEY,
idTipoTarjeta INT REFERENCES TIPO_TARJETA(idTipoTarjeta),
idEstado INT REFERENCES ESTADOS_ENTIDADES(idEstado),
saldoDisponible FLOAT,
fechaCreacion DATETIME
)
GO

CREATE TABLE CUENTA(
idCuenta INT IDENTITY PRIMARY KEY,
nombrePropietario VARCHAR(100),
apellidos VARCHAR(100),
telefono varchar(9),
dni varchar (8),
direccion varchar(250),
correo varchar(50),
idEstado INT REFERENCES ESTADOS_ENTIDADES(idEstado),
idUsuario INT REFERENCES USUARIO(idUsuario),
idTarjeta INT REFERENCES TARJETA(idTarjeta)
)
GO

CREATE TABLE METODO_PAGO(
idMetodoPago INT IDENTITY PRIMARY KEY,
nombreMetodo VARCHAR(20)
)
GO

CREATE TABLE TIPO_RECARGA(
idTipoRecarga INT IDENTITY PRIMARY KEY,
nombreTipo VARCHAR(50)
)
GO

CREATE TABLE RECARGA(
idRecarga INT IDENTITY PRIMARY KEY,
montoRecarga float,
fechaRecarga DATETIME,
idMetodoPago INT REFERENCES METODO_PAGO(idMetodoPago),
idTipoRecarga INT REFERENCES TIPO_RECARGA(idTipoRecarga),
idEstado INT REFERENCES ESTADOS_ENTIDADES(idEstado)
)
GO
CREATE TABLE ESTACIONES	(
idEstacion INT IDENTITY PRIMARY KEY,
nombreEstacion	VARCHAR(150)
)
GO

CREATE TABLE CONSUMO(
IdConsumo INT IDENTITY PRIMARY KEY,	
montoConsumo FLOAT,
fechaConsumo DATETIME,
IdEstacionInicial INT REFERENCES ESTACIONES(idEstacion),
idEstado INT REFERENCES ESTADOS_ENTIDADES(idEstado)
)
GO

CREATE TABLE TRANSFERENCIAS (
IdTransferencia	INT	IDENTITY PRIMARY KEY,
montoTransferencia	FLOAT,
fechaTransferencia	DATETIME,
idEstado INT REFERENCES ESTADOS_ENTIDADES(idEstado),
idCuentaDestino	INT
)
GO

CREATE TABLE TIPO_TRANSACCIONES(
idTipoTransaccion INT IDENTITY PRIMARY KEY,
nombreTipo VARCHAR(50)
)
GO

CREATE TABLE HISTORIAL_TARJETA(
idTarjeta INT REFERENCES TARJETA(idTarjeta),
idTipoTransaccion INT REFERENCES TIPO_TRANSACCIONES(idTipoTransaccion), 
idTransaccion INT
)
GO