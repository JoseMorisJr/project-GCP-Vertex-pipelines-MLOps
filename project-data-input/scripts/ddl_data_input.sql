
-- Crear dataset

CREATE SCHEMA IF NOT EXISTS `gcp-data-bigquery-prod-us-east.hist_table`
OPTIONS (
  location = "US",
  description = "Dataset creado en la multirregión de US para almacenar las tablas de historicos."
);


----------------------------------------------------------------------------------

-- Creacion de tabla para almacenar los datos de entrada para la predicción de precios de viviendas

CREATE OR REPLACE TABLE `gcp-data-bigquery-prod-us-east.hist_table.input_data` 
(
  id                        INT64,
  mssubclass                INT64,
  mszoning                  STRING,
  lotfrontage               FLOAT64,
  lotarea                   INT64,
  street                    STRING,
  alley                     STRING,
  lotshape                  STRING,
  landcontour               STRING,
  utilities                 STRING,
  lotconfig                 STRING,
  landslope                 STRING,
  neighborhood              STRING,
  condition                 STRING,
  condition_secundaria      STRING,
  bldgtype                  STRING,
  housestyle                STRING,
  overallqual               INT64,
  overallcond               INT64,
  yearbuilt                 INT64,
  yearremodadd              INT64,
  roofstyle                 STRING,
  roofmatl                  STRING,
  exterior_principal        STRING,
  exterior_secundario       STRING,
  masvnrtype                STRING,
  masvnrarea                FLOAT64,
  exterqual                 STRING,
  extercond                 STRING,
  foundation                STRING,
  bsmtqual                  STRING,
  bsmtcond                  STRING,
  bsmtexposure              STRING,
  bsmtfintype_principal     STRING,
  bsmtfinsf_principal       FLOAT64,
  bsmtfintype_secundario    STRING,
  bsmtfinsf_secundario      FLOAT64,
  bsmtunfsf                 FLOAT64,
  totalbsmtsf               FLOAT64,
  heating                   STRING,
  heatingqc                 STRING,
  centralair                STRING,
  electrical                STRING,
  firstflrsf                FLOAT64,
  secondflrsf               FLOAT64,
  lowqualfinsf              FLOAT64,
  grlivarea                 FLOAT64,
  bsmtfullbath              FLOAT64,
  bsmthalfbath              FLOAT64,
  fullbath                  INT64,
  halfbath                  INT64,
  bedroomabvgr              INT64,
  kitchenabvgr              INT64,
  kitchenqual               STRING,
  totrmsabvgrd              INT64,
  functional                STRING,
  fireplaces                INT64,
  fireplacequ               STRING,
  garagetype                STRING,
  garageyrblt               FLOAT64,
  garagefinish              STRING,
  garagecars                FLOAT64,
  garagearea                FLOAT64,
  garagequal                STRING,
  garagecond                STRING,
  paveddrive                STRING,
  wooddecksf                FLOAT64,
  openporchsf               FLOAT64,
  enclosedporch             FLOAT64,
  ssnporch                  FLOAT64,
  screenporch               FLOAT64,
  poolarea                  FLOAT64,
  poolqc                    STRING,
  fence                     STRING,
  miscfeature               STRING,
  miscval                   FLOAT64,
  mosold                    INT64,
  yrsold                    INT64,
  saletype                  STRING,
  salecondition             STRING,
  date_subida               TIMESTAMP
)
OPTIONS (
  description = "Datos de entrada para la predicción de precios de viviendas"
);