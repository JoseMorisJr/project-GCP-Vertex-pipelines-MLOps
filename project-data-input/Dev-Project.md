1. Crear el projecto en GCP.
    - Nombre: `gcp-data-bigquery-prod-us-east`

2. Ejecutar el script de `ddl_data_input.sql` en la consola de BigQuery.

3. Crear entorno de ejecucion con `uv`.
    - Trasladarte desde la raiz del proyecto y ejecutar las siguientes lineas de codigo: 
        cd .\project-data-input\     
        uv venv  --python 3.9
        .venv\Scripts\activate
        uv pip install -r requirements.txt

4. Levantar el entorno de notebook desde la raiz de este proyecto.

5. Ejecutar el notebook que se encuentra en scripts/Add_data_BQ.ipynb

6. Darle permisos a la cuenta de servicio en IAM y Big Query.

