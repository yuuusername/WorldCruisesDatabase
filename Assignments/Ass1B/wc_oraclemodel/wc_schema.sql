-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-04-28 01:05:11 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

--student id: 32505779
--student name: Dylan Hor
-- Capture run of script in file called custorders_schema_output.txt
set echo on
SPOOL wc_schema_output.txt


DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE cabin CASCADE CONSTRAINTS;

DROP TABLE country CASCADE CONSTRAINTS;

DROP TABLE cruise CASCADE CONSTRAINTS;

DROP TABLE docking CASCADE CONSTRAINTS;

DROP TABLE manifest CASCADE CONSTRAINTS;

DROP TABLE operator CASCADE CONSTRAINTS;

DROP TABLE passenger CASCADE CONSTRAINTS;

DROP TABLE passenger_tour CASCADE CONSTRAINTS;

DROP TABLE port CASCADE CONSTRAINTS;

DROP TABLE port_temperature CASCADE CONSTRAINTS;

DROP TABLE ship CASCADE CONSTRAINTS;

DROP TABLE tour CASCADE CONSTRAINTS;

DROP TABLE town CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    add_id        NUMBER(5) NOT NULL,
    town_postcode CHAR(4) NOT NULL,
    country_code  CHAR(2) NOT NULL,
    add_street    VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN address.add_id IS
    'Unique identifier for addresses';

COMMENT ON COLUMN address.town_postcode IS
    'Postcode for the related town only accepting values from (1000,9999)';

COMMENT ON COLUMN address.country_code IS
    'Code of the country ';

COMMENT ON COLUMN address.add_street IS
    'Street of the address';

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( add_id );

ALTER TABLE address
    ADD CONSTRAINT address_nk UNIQUE ( add_street,
                                       town_postcode,
                                       country_code );

CREATE TABLE cabin (
    cab_id    NUMBER(4) NOT NULL,
    ship_code NUMBER(5) NOT NULL,
    cab_cap   NUMBER(2),
    cab_class VARCHAR2(20)
);

ALTER TABLE cabin
    ADD CONSTRAINT chk_cabclass CHECK ( cab_class IN ( 'Balcony', 'Interior', 'Ocean View',
    'Suite' ) );

COMMENT ON COLUMN cabin.cab_id IS
    'Cabin ID';

COMMENT ON COLUMN cabin.ship_code IS
    'Ship unique identifer';

COMMENT ON COLUMN cabin.cab_cap IS
    'Cabin Capacity';

COMMENT ON COLUMN cabin.cab_class IS
    'Cabin Class';

ALTER TABLE cabin ADD CONSTRAINT cabin_pk PRIMARY KEY ( cab_id,
                                                        ship_code );

CREATE TABLE country (
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN country.country_code IS
    'Code of the country ';

COMMENT ON COLUMN country.country_name IS
    'Name of Country ';

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country_code );

CREATE TABLE cruise (
    cru_id   NUMBER(4) NOT NULL,
    cru_name VARCHAR2(50) NOT NULL,
    cru_desc VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN cruise.cru_id IS
    'Cruise Id number ';

COMMENT ON COLUMN cruise.cru_name IS
    'Name of cruise';

COMMENT ON COLUMN cruise.cru_desc IS
    'Description of the type of cruise ';

ALTER TABLE cruise ADD CONSTRAINT cruise_pk PRIMARY KEY ( cru_id );

CREATE TABLE docking (
    visit_datetime DATE NOT NULL,
    cru_id         NUMBER(4) NOT NULL,
    port_code      CHAR(5) NOT NULL,
    visit_reason   CHAR(6) NOT NULL
);

ALTER TABLE docking
    ADD CONSTRAINT chk_reason CHECK ( visit_reason IN ( 'arrive', 'depart' ) );

COMMENT ON COLUMN docking.visit_datetime IS
    'The date and time of the record of port visit';

COMMENT ON COLUMN docking.cru_id IS
    'Cruise Id number ';

COMMENT ON COLUMN docking.port_code IS
    'The code recorded to identify the port landed at in a cruise';

COMMENT ON COLUMN docking.visit_reason IS
    'Visit reasons can only be two values, arrive and depart';

ALTER TABLE docking
    ADD CONSTRAINT port_visited_pk PRIMARY KEY ( cru_id,
                                                 port_code,
                                                 visit_datetime );

CREATE TABLE manifest (
    cru_id    NUMBER(4) NOT NULL,
    pass_id   NUMBER(5) NOT NULL,
    cab_id    NUMBER(4) NOT NULL,
    ship_code NUMBER(5) NOT NULL
);

COMMENT ON COLUMN manifest.cru_id IS
    'Cruise Id number ';

COMMENT ON COLUMN manifest.pass_id IS
    'Passenger ID';

COMMENT ON COLUMN manifest.cab_id IS
    'Cabin ID';

COMMENT ON COLUMN manifest.ship_code IS
    'Ship unique identifer';

ALTER TABLE manifest
    ADD CONSTRAINT manifest_pk PRIMARY KEY ( pass_id,
                                             cab_id,
                                             ship_code,
                                             cru_id );

CREATE TABLE operator (
    op_id         NUMBER(4) NOT NULL,
    comp_name     VARCHAR2(40) NOT NULL,
    comp_ceo_name VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN operator.op_id IS
    'The unique identification for operator';

COMMENT ON COLUMN operator.comp_name IS
    'The name of the company the operator works for';

COMMENT ON COLUMN operator.comp_ceo_name IS
    'The name of the CEO of the company the operator works for';

ALTER TABLE operator ADD CONSTRAINT operator_pk PRIMARY KEY ( op_id );

CREATE TABLE passenger (
    pass_id                  NUMBER(5) NOT NULL,
    add_id                   NUMBER(5) NOT NULL,
    pass_fname               VARCHAR2(20) NOT NULL,
    pass_lname               VARCHAR2(20) NOT NULL,
    pass_gender              VARCHAR2(6) NOT NULL,
    pass_dob                 DATE NOT NULL,
    pass_board_datetime      DATE NOT NULL,
    pass_principals_language CHAR(2) NOT NULL,
    pass_street              VARCHAR2(100) NOT NULL,
    pass_guardian_id         NUMBER(7)
);

ALTER TABLE passenger
    ADD CONSTRAINT chk_gender CHECK ( pass_gender IN ( 'Female', 'Male' ) );

COMMENT ON COLUMN passenger.pass_id IS
    'Passenger ID';

COMMENT ON COLUMN passenger.add_id IS
    'Unique identifier for addresses';

COMMENT ON COLUMN passenger.pass_fname IS
    'Passenger First Name';

COMMENT ON COLUMN passenger.pass_lname IS
    'Passenger Last Name';

COMMENT ON COLUMN passenger.pass_gender IS
    'Passenger Gender (Male, Female)';

COMMENT ON COLUMN passenger.pass_dob IS
    'Passenger Date of Birth';

COMMENT ON COLUMN passenger.pass_board_datetime IS
    'Passenger Time of Boarding';

COMMENT ON COLUMN passenger.pass_principals_language IS
    'Passenger Principal Spoken Language';

COMMENT ON COLUMN passenger.pass_street IS
    'Name of the street lived at';

COMMENT ON COLUMN passenger.pass_guardian_id IS
    'The passenger ID of the guardian taking care of this minor';

ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY ( pass_id );

CREATE TABLE passenger_tour (
    tour_date    DATE NOT NULL,
    tour_no      NUMBER(3) NOT NULL,
    port_code    CHAR(5) NOT NULL,
    pass_id      NUMBER(5) NOT NULL,
    pay_recieved VARCHAR2(3) NOT NULL
);

ALTER TABLE passenger_tour
    ADD CONSTRAINT chk_pay_rec CHECK ( pay_recieved IN ( 'No', 'Yes' ) );

COMMENT ON COLUMN passenger_tour.tour_date IS
    'The date of the tour passenger was on';

COMMENT ON COLUMN passenger_tour.tour_no IS
    'Tour Number';

COMMENT ON COLUMN passenger_tour.port_code IS
    'The code recorded to identify the port landed at in a cruise';

COMMENT ON COLUMN passenger_tour.pass_id IS
    'Passenger ID';

COMMENT ON COLUMN passenger_tour.pay_recieved IS
    'Payment Recieved from passenger (Yes, No)';

ALTER TABLE passenger_tour
    ADD CONSTRAINT tour_passenger_pk PRIMARY KEY ( tour_date,
                                                   tour_no,
                                                   port_code,
                                                   pass_id );

CREATE TABLE port (
    port_code    CHAR(5) NOT NULL,
    country_code CHAR(2) NOT NULL,
    port_name    VARCHAR2(50) NOT NULL,
    port_pop     NUMBER(9) NOT NULL,
    port_long    NUMBER(10, 6) NOT NULL,
    port_lat     NUMBER(10, 6) NOT NULL
);

COMMENT ON COLUMN port.port_code IS
    'The code recorded to identify the port landed at in a cruise';

COMMENT ON COLUMN port.country_code IS
    'Code of the country ';

COMMENT ON COLUMN port.port_name IS
    'The name of the port landed at';

COMMENT ON COLUMN port.port_pop IS
    'The population at the specific port';

COMMENT ON COLUMN port.port_long IS
    'Longitude of the port';

COMMENT ON COLUMN port.port_lat IS
    'Latitude of the port';

ALTER TABLE port ADD CONSTRAINT port_pk PRIMARY KEY ( port_code );

CREATE TABLE port_temperature (
    temp_month VARCHAR2(4) NOT NULL,
    port_code  CHAR(5) NOT NULL,
    temp_high  NUMBER(3, 1) NOT NULL,
    temp_low   NUMBER(3, 1) NOT NULL
);

ALTER TABLE port_temperature
    ADD CONSTRAINT chk_month CHECK ( temp_month IN ( 'Apr', 'Aug', 'Dec', 'Feb', 'Jan',
                                                     'Jul', 'Jun', 'Mar', 'May', 'Nov',
                                                     'Oct', 'Sep' ) );

ALTER TABLE port_temperature ADD CHECK ( temp_high BETWEEN 0 AND 99 );

COMMENT ON COLUMN port_temperature.temp_month IS
    'Months in the year (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec)';

COMMENT ON COLUMN port_temperature.port_code IS
    'The code recorded to identify the port landed at in a cruise';

COMMENT ON COLUMN port_temperature.temp_high IS
    'Highest average temperature for the month';

COMMENT ON COLUMN port_temperature.temp_low IS
    'Lowest average temperature for the month';

ALTER TABLE port_temperature ADD CONSTRAINT port_temperature_pk PRIMARY KEY ( temp_month,
                                                                              port_code );

CREATE TABLE ship (
    ship_code      NUMBER(5) NOT NULL,
    op_id          NUMBER(4) NOT NULL,
    country_code   CHAR(2) NOT NULL,
    ship_name      VARCHAR2(50) NOT NULL,
    ship_date_comm DATE NOT NULL,
    ship_tonnage   NUMBER(8, 2) NOT NULL,
    ship_cap       NUMBER(7)
);

COMMENT ON COLUMN ship.ship_code IS
    'Ship unique identifer';

COMMENT ON COLUMN ship.op_id IS
    'The unique identification for operator';

COMMENT ON COLUMN ship.country_code IS
    'Code of the country ';

COMMENT ON COLUMN ship.ship_name IS
    'The name of the ship';

COMMENT ON COLUMN ship.ship_date_comm IS
    'The date the ship was commissioned ';

COMMENT ON COLUMN ship.ship_tonnage IS
    'The specified tonnage of the ship';

COMMENT ON COLUMN ship.ship_cap IS
    'The maximum guest capacity of the ship';

ALTER TABLE ship ADD CONSTRAINT ship_pk PRIMARY KEY ( ship_code );

CREATE TABLE tour (
    tour_no            NUMBER(3) NOT NULL,
    port_code          CHAR(5) NOT NULL,
    tour_name          VARCHAR2(20) NOT NULL,
    tour_desc          VARCHAR2(100) NOT NULL,
    tour_hours_req     NUMBER(3, 1) NOT NULL,
    tour_cost_pp       NUMBER(5, 2) NOT NULL,
    tour_wheelc_access VARCHAR2(3) NOT NULL,
    tour_avail         VARCHAR2(30) NOT NULL,
    tour_st            DATE NOT NULL
);

ALTER TABLE tour
    ADD CONSTRAINT chk_wheelc CHECK ( tour_wheelc_access IN ( 'No', 'Yes' ) );

COMMENT ON COLUMN tour.tour_no IS
    'Tour Number';

COMMENT ON COLUMN tour.port_code IS
    'The code recorded to identify the port landed at in a cruise';

COMMENT ON COLUMN tour.tour_name IS
    'Tour Name';

COMMENT ON COLUMN tour.tour_desc IS
    'Tour Descripition';

COMMENT ON COLUMN tour.tour_hours_req IS
    'Hours Required for Tour';

COMMENT ON COLUMN tour.tour_cost_pp IS
    'Tour Cost Per Person';

COMMENT ON COLUMN tour.tour_wheelc_access IS
    'WheelChair Access for the tour (Yes, No)';

COMMENT ON COLUMN tour.tour_avail IS
    'Tour Availability';

COMMENT ON COLUMN tour.tour_st IS
    'Tour StartTime';

ALTER TABLE tour ADD CONSTRAINT tour_pk PRIMARY KEY ( tour_no,
                                                      port_code );

CREATE TABLE town (
    town_postcode CHAR(4) NOT NULL,
    town_name     VARCHAR2(50) NOT NULL
);

ALTER TABLE town
    ADD CONSTRAINT chk_postcode CHECK ( town_postcode BETWEEN '1000' AND '9999' );

COMMENT ON COLUMN town.town_postcode IS
    'Postcode for the related town only accepting values from (1000,9999)';

COMMENT ON COLUMN town.town_name IS
    'The name of the town';

ALTER TABLE town ADD CONSTRAINT town_pk PRIMARY KEY ( town_postcode );

ALTER TABLE passenger
    ADD CONSTRAINT address_passenger FOREIGN KEY ( add_id )
        REFERENCES address ( add_id );

ALTER TABLE manifest
    ADD CONSTRAINT cabin_manifest FOREIGN KEY ( cab_id,
                                                ship_code )
        REFERENCES cabin ( cab_id,
                           ship_code );

ALTER TABLE address
    ADD CONSTRAINT country_address FOREIGN KEY ( country_code )
        REFERENCES country ( country_code );

ALTER TABLE port
    ADD CONSTRAINT country_port FOREIGN KEY ( country_code )
        REFERENCES country ( country_code );

ALTER TABLE ship
    ADD CONSTRAINT country_ship FOREIGN KEY ( country_code )
        REFERENCES country ( country_code );

ALTER TABLE docking
    ADD CONSTRAINT cruise_docking FOREIGN KEY ( cru_id )
        REFERENCES cruise ( cru_id );

ALTER TABLE manifest
    ADD CONSTRAINT cruise_manifest FOREIGN KEY ( cru_id )
        REFERENCES cruise ( cru_id );

ALTER TABLE manifest
    ADD CONSTRAINT manifest_passenger FOREIGN KEY ( pass_id )
        REFERENCES passenger ( pass_id );

ALTER TABLE ship
    ADD CONSTRAINT operator_ship FOREIGN KEY ( op_id )
        REFERENCES operator ( op_id );

ALTER TABLE passenger_tour
    ADD CONSTRAINT pass_pass_tour FOREIGN KEY ( pass_id )
        REFERENCES passenger ( pass_id );

ALTER TABLE docking
    ADD CONSTRAINT port_docking FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE port_temperature
    ADD CONSTRAINT port_port_temp FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE tour
    ADD CONSTRAINT port_tour FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE cabin
    ADD CONSTRAINT ship_cabin FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE passenger_tour
    ADD CONSTRAINT tour_pass_tour FOREIGN KEY ( tour_no,
                                                port_code )
        REFERENCES tour ( tour_no,
                          port_code );

ALTER TABLE address
    ADD CONSTRAINT town_address FOREIGN KEY ( town_postcode )
        REFERENCES town ( town_postcode );


SPOOL off
set echo off

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

