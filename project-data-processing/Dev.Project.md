1. Crear el projecto en GCP.
    - Nombre: `gcp-processing-vertex-prod-us`

2. Crear la cuenta de servicio.
    - Nombre: `sa-processing-crun-vertex-prod@gcp-processing-vertex-prod-us.iam.gserviceaccount.com`

3. Dar los permisos que se especifican en permissions.

4. Crear el bucket `gcp-processing-storage-prod` en el servicio de storage.

5. Crear las rutas de carpeta: 
    - `/gcp-processing-storage-prod/project-pipeline-predictions-casas/models`
    - `/gcp-processing-storage-prod/project-pipeline-predictions-casas/pipeline_predictions`

6. Crear entorno de ejecucion con `uv`.
    - Trasladarte desde la raiz del proyecto y ejecutar las siguientes lineas de codigo: 
        cd .\project-data-processing\     
        uv venv  --python 3.9
        .venv\Scripts\activate
        uv pip install -r requirements.txt

7. Levantar el entorno de notebook desde la raiz de este proyecto.

8. Ejecutar el notebook que se encuentra en scripts/Add_model_storage.ipynb

9. Ejecutar el sql que se encuentra en scripts/ddl_data_input.sql en la consola de BigQuery del proyecto

10. Ejecutar el notebook que se encuentra en scripts/Add_data_BQ.ipynb

11. 