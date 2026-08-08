
-- Crear dataset

CREATE SCHEMA IF NOT EXISTS `gcp-processing-vertex-prod-us.dev_table`
OPTIONS (
  location = "US",
  description = "Dataset creado en la multirregión de US para almacenar las tablas de temporales y auxiliares."
);


----------------------------------------------------------------------------------

-- Creacion de tabla para almacenar los datos de entrada para la predicción de precios de viviendas

CREATE OR REPLACE TABLE `gcp-processing-vertex-prod-us.dev_table.features_input` 
(
  features                  STRING,
  date_subida_local         DATETIME,
  date_subida_utc           TIMESTAMP
)
OPTIONS (
  description = "Datos de entrada para la predicción de precios de viviendas"
);

----------------------------------------------------------------------------------

-- Creacion de tabla temporal de features_input 

CREATE OR REPLACE TABLE `gcp-processing-vertex-prod-us.dev_table.temp_data_input` 
(
id                                     int64,
periodo                               STRING,
mssubclass                             Int64,
mszoning                              STRING,
lotfrontage                          float64,
lotarea                                Int64,
neighborhood                          STRING,
overallqual                            Int64,
overallcond                            Int64,
yearbuilt                              Int64,
yearremodadd                           Int64,
bsmtqual                              STRING,
bsmtfintype_principal                 STRING,
bsmtfinsf_principal                  float64,
totalbsmtsf                          float64,
centralair                            STRING,
firstflrsf                           float64,
secondflrsf                          float64,
grlivarea                            float64,
kitchenqual                           STRING,
fireplacequ                           STRING,
garagetype                            STRING,
garagecars                           float64,
garagearea                           float64,
yrsold                                 Int64,
run_id                                STRING,
creation_user                         STRING,
str_process_date_local                STRING,
process_datetime_local              DATETIME,
process_datetime_utc               TIMESTAMP
)
OPTIONS (
  description = "Datos de entrada temporal para la predicción de precios de viviendas"
);


----------------------------------------------------------------------------------

-- Creacion de tabla temporal de transformacion
CREATE OR REPLACE TABLE `gcp-processing-vertex-prod-us.dev_table.temp_data_transformed` 
(
id                                            int64,
periodo                                      STRING,
mssubclass_transf                           float64,
mszoning_transf                             float64,
lotfrontage_transf                          float64,
lotarea_transf                              float64,
neighborhood_transf                         float64,
overallqual_transf                          float64,
overallcond_transf                          float64,
yearbuilt_transf                            float64,
yearremodadd_transf                         float64,
bsmtqual_transf                             float64,
bsmtfintype_principal_transf                float64,
bsmtfinsf_principal_transf                  float64,
totalbsmtsf_transf                          float64,
centralair_transf                           float64,
firstflrsf_transf                           float64,
secondflrsf_transf                          float64,
grlivarea_transf                            float64,
kitchenqual_transf                          float64,
fireplacequ_transf                          float64,
garagetype_transf                           float64,
garagecars_transf                           float64,
garagearea_transf                           float64,
lotfrontage_na_transf                       float64,
run_id                                      STRING,
creation_user                               STRING,
str_process_date_local                      STRING,
process_datetime_local                      DATETIME,
process_datetime_utc                        TIMESTAMP

)
OPTIONS (
  description = "Datos de tranformados temporal"
);


----------------------------------------------------------------------------------

-- Creacion de tabla temporal de transformacion
CREATE OR REPLACE TABLE `gcp-processing-vertex-prod-us.dev_table.temp_data_predict` 
(
id                                            int64,
periodo                                       STRING,
saleprice_predict                             FLOAT64,
model_name                                    STRING,
run_id                                        STRING,
creation_user                                 STRING,
str_process_date_local                        STRING,
process_datetime_local                        DATETIME,
process_datetime_utc                          TIMESTAMP
)
OPTIONS (
  description = "Datos de tranformados temporal"
);


----------------------------------------------------------------------------------

-- Creacion de tabla temporal de salida
CREATE OR REPLACE TABLE `gcp-processing-vertex-prod-us.dev_table.model_execution_audit` 
(
periodo                     STRING,
run_id                      STRING,
model_name                  STRING,
model_path_gcs              STRING,
pipeline_path_gcs           STRING,
rows_processed              int64,
str_process_date_local      STRING,
process_datetime_local      DATETIME,
process_datetime_utc        TIMESTAMP
)
OPTIONS (
  description = "Auditoria del uso del model."
);

----------------------------------------------------------------------------------

-- Creacion de procedimiento
CREATE OR REPLACE PROCEDURE `gcp-processing-vertex-prod-us.dev_table.sp_table_out_model`(
    p_periodo STRING
)
BEGIN
    SELECT
      t1.id,
      t1.periodo,
      t1.mssubclass,                 
      t1.mszoning,                   
      t1.lotfrontage,                
      t1.lotarea,                    
      t1.neighborhood,               
      t1.overallqual,                
      t1.overallcond,                
      t1.yearbuilt,                  
      t1.yearremodadd,               
      t1.bsmtqual,                   
      t1.bsmtfintype_principal,      
      t1.bsmtfinsf_principal,        
      t1.totalbsmtsf,                
      t1.centralair,                 
      t1.firstflrsf,                 
      t1.secondflrsf,                
      t1.grlivarea,                  
      t1.kitchenqual,                
      t1.fireplacequ,                
      t1.garagetype,                
      t1.garagecars,                 
      t1.garagearea,                 
      t1.yrsold,                     
      t2.saleprice_predict as saleprice

    FROM `gcp-processing-vertex-prod-us.dev_table.temp_data_input` AS t1

    LEFT JOIN `gcp-processing-vertex-prod-us.dev_table.temp_data_predict` AS t2
        ON  t1.id = t2.id
        AND t1.periodo = t2.periodo

    WHERE t1.periodo = p_periodo
      AND t2.periodo = p_periodo
    ;

END;