
## Permisos para Cuenta Servicio 

Para la cuenta de servicio creada se le asignan los siguientes permisos:

1. A nivel del servicio de BigQuery del proyecto `gcp-data-bigquery-prod-us-east`:
    - Visualizador de datos de BigQuery

2. Ejecutar los permisos para la actual cuenta de servicio en la terminal de GCP: 

```bash
#Define variables
SERVICE_ACCOUNT="sa-processing-crun-vertex-prod@gcp-processing-vertex-prod-us.iam.gserviceaccount.com"
PROJECT_ID="gcp-processing-vertex-prod-us"

# Asignar el rol Artifact Registry Reader
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/artifactregistry.reader"

# Asignar el rol BigQuery Job User
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/bigquery.jobUser"

# Asignar el rol BigQuery Read Session User
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/bigquery.readSessionUser"

# Asignar el rol BigQuery Resource Viewer
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/bigquery.resourceViewer"

# Asignar el rol Logs Writer
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/logging.logWriter"

# Asignar el rol Monitoring Metric Writer
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/monitoring.metricWriter"

# Asignar el rol Monitoring Viewer
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/monitoring.viewer"
    
# Asignar el rol Token Creator  
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role=roles/iam.serviceAccountOpenIdTokenCreator

# Asignar el rol Vertex AI User
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/aiplatform.user"

```

3. A nivel de la cuenta de servicio agregarle los siguientes permisos:
    - Editor de storage
    - Creador de objetos de storage
    - Visualizador de objetos de storage
    - Visualizador de datos de BigQuery
    - Editor de datos de BigQuery

4. 