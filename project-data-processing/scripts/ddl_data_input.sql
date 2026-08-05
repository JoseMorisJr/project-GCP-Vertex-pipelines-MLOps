
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