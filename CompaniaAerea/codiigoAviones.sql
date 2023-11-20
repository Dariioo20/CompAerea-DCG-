CREATE DATABASE IF NOT EXISTS CompañiaAerea;

USE CompañiaAerea;

CREATE TABLE T_AVION (
	MatriculaAvion varchar(25) PRIMARY KEY,
	FabricanteAvion varchar(35) NOT NULL,
	ModeloAvion varchar(35) NOT NULL,
	CapacidadAvion int NOT NULL,
	AutonomiaAvion varchar(10) NOT NULL
);

CREATE TABLE T_VUELO (
	IdVuelo int PRIMARY KEY NOT NULL,
	MatriculaAvion varchar(25),
	OrigenVuelo varchar(25) NOT NULL,
	DestinoVuelo varchar(25) NOT NULL,
	FechaVuelo DATE NOT NULL,
	CONSTRAINT FK_T_VUELO_T_AVION
	FOREIGN KEY (MatriculaAvion)	REFERENCES T_AVION(MatriculaAvion)
);

CREATE TABLE T_PASAJERO (
	DNIPasajero varchar(9) PRIMARY KEY NOT NULL,
	NombrePasajero varchar(20) NOT NULL,
	ApellidosPasajero varchar(50) NOT NULL,	
	EmailPasajero varchar(30)
);

CREATE TABLE T_TELEFONO_PASAJERO (
	TLFPasajero int PRIMARY KEY NOT NULL,
	DNIPasajero varchar(9),
	CONSTRAINT FK_T_PASAJERO_T_TELEFONO_PASAJERO
	FOREIGN KEY (DNIPasajero) REFERENCES T_PASAJERO(DNIPasajero)
);
	
CREATE TABLE T_DISTRIBUCION (
	DNIPasajero varchar(9),
	IdVuelo int,
	Asiento varchar(6) NOT NULL,
	Clase varchar(15) NOT NULL,
	CONSTRAINT FK_T_DISTRIBUCION_T_PASAJERO  
    	FOREIGN KEY (DNIPasajero) REFERENCES T_PASAJERO(DNIPasajero),
    	CONSTRAINT FK_T_DISTRIBUCION_T_VUELO 
   	FOREIGN KEY (IdVuelo) REFERENCES T_VUELO(IdVuelo),
    	PRIMARY KEY (DNIPasajero, IdVuelo)
);

CREATE TABLE T_CAT_PROFESIONAL (
	IDCategoria int PRIMARY KEY NOT NULL,
	NombreCategoria varchar(30) NOT NULL
);

CREATE TABLE T_PERSONAL (
	IDTrabajador int PRIMARY KEY NOT NULL,
	IDCategoria int,
	NombreTrabajador varchar(20) NOT NULL,
	Apellido1Trabajador varchar(20) NOT NULL,
	Apellido2Trabajador varchar(20),
	CONSTRAINT FK_T_PERSONAL_T_CAT_PROFESIONAL
	FOREIGN KEY (IDCategoria) REFERENCES T_CAT_PROFESIONAL(IDCategoria)
);

CREATE TABLE T_PUESTO (
	IDTrabajador int,
	IdVuelo int,
	Puesto varchar(20) NOT NULL,
	CONSTRAINT FK_T_DISTRIBUCION_T_PERSONAL 
    	FOREIGN KEY (IDTrabajador) REFERENCES T_PERSONAL(IDTrabajador),
    	CONSTRAINT FK_T_PUESTO_T_VUELO 
   	FOREIGN KEY (IdVuelo) REFERENCES T_VUELO(IdVuelo),
    	PRIMARY KEY (IDTrabajador, IdVuelo)
);

CREATE TABLE T_TLF_PERSONAL (
	TelefonoPersonal int PRIMARY KEY NOT NULL,	
	IDTrabajador int,
	CONSTRAINT FK_T_TLF_PERSONAL_T_PERSONAL 
    	FOREIGN KEY (IDTrabajador) REFERENCES T_PERSONAL(IDTrabajador)
);