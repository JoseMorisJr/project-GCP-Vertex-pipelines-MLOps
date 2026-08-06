
-- Crear dataset

CREATE SCHEMA IF NOT EXISTS `gcp-output-bigquery-prod-us-ea.prod_table`
OPTIONS (
  location = "US",
  description = "Dataset creado en la multirregión de US para almacenar las de produccion."
);

--------------------------------------------------------------------------

-- Creacion de tabla final de salida
CREATE OR REPLACE TABLE `gcp-output-bigquery-prod-us-ea.prod_table.ba_modelo_propension_inscripcion` 
(
id                                            int64,
periodo                                      STRING,
mssubclass                                    Int64,
mszoning                                     STRING,
lotfrontage                                 float64,
lotarea                                       Int64,
neighborhood                                 STRING,
overallqual                                   Int64,
overallcond                                   Int64,
yearbuilt                                     Int64,
yearremodadd                                  Int64,
bsmtqual                                     STRING,
bsmtfintype_principal                        STRING,
bsmtfinsf_principal                         float64,
totalbsmtsf                                 float64,
centralair                                   STRING,
firstflrsf                                  float64,
secondflrsf                                 float64,
grlivarea                                   float64,
kitchenqual                                  STRING,
fireplacequ                                  STRING,
garagetype                                   STRING,
garagecars                                  float64,
garagearea                                  float64,
yrsold                                        Int64,
saleprice                                   float64,
date_subida_local                          DATETIME,
date_subida_utc                           TIMESTAMP

)
OPTIONS (
  description = "Datos de salida final de produccion"
);

--------------------------------------------------------------------------

-- Creacion de tabla final de salida
CREATE OR REPLACE TABLE `gcp-output-bigquery-prod-us-ea.prod_table.ba_aux_modelo_universo` 
(
id                                            int64,
periodo                                      STRING,
mssubclass                                    Int64,
mszoning                                     STRING,
lotfrontage                                 float64,
lotarea                                       Int64,
neighborhood                                 STRING,
overallqual                                   Int64,
overallcond                                   Int64,
yearbuilt                                     Int64,
yearremodadd                                  Int64,
bsmtqual                                     STRING,
bsmtfintype_principal                        STRING,
bsmtfinsf_principal                         float64,
totalbsmtsf                                 float64,
centralair                                   STRING,
firstflrsf                                  float64,
secondflrsf                                 float64,
grlivarea                                   float64,
kitchenqual                                  STRING,
fireplacequ                                  STRING,
garagetype                                   STRING,
garagecars                                  float64,
garagearea                                  float64,
yrsold                                        Int64,
saleprice                                   float64,
date_subida_local                          DATETIME,
date_subida_utc                           TIMESTAMP

)
OPTIONS (
  description = "Datos de salida final de produccion historica"
);
