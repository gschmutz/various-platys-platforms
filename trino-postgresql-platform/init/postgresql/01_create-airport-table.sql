CREATE SCHEMA flight_data;

DROP TABLE IF EXISTS flight_data.airport_t;

CREATE TABLE IF NOT EXISTS flight_data.airport_t
(
  iata character varying(50) NOT NULL,
  airport character varying(50),
  city character varying(50),
  state character varying(50),
  country character varying(50),
  lat float,
  long float,
  CONSTRAINT airport_pk PRIMARY KEY (iata)
);


COPY flight_data.airport_t(iata,airport,city,state,country,lat,long) 
FROM '/data-transfer/flight-data/airports.csv' DELIMITER ',' CSV HEADER;
