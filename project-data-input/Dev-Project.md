1. Crear el projecto en GCP.
    - Nombre: `gcp-data-bigquery-prod-us-east`

2. Crear la cuenta de servicio.
    - Nombre: `sa-data-bigquery-prod-01@gcp-data-bigquery-prod-us-east.iam.gserviceaccount.com`

3. Darle permisos a la cuenta de servicio en Big Query.

4. Ejecutar el script de `ddl_data_input.sql` en la consola de BigQuery.

5. Crear entorno de ejecucion con `uv`.
    - Trasladarte desde la raiz del proyecto y ejecutar las siguientes lineas de codigo: 
        cd .\project-data-input\     
        uv venv  --python 3.9
        .venv\Scripts\activate
        uv pip install -r requirements.txt

6. Levantar el entorno de notebook desde la raiz de este proyecto.

7. Ejecutar el notebook que se encuentra en scripts/Add_data_BQ.ipynb

