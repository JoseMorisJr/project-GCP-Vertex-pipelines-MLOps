
## Permisos para Cuenta Servicio (sa-processing-crun-vertex-prod@gcp-processing-vertex-prod-us.iam.gserviceaccount.com)

Para la cuentas de servicios creadas se le asignan los siguientes permisos:

1. Ejecutar los permisos para la actual cuenta de servicio en la terminal de GCP: 

```bash
#Define variables
SERVICE_ACCOUNT="sa-processing-crun-vertex-prod@gcp-processing-vertex-prod-us.iam.gserviceaccount.com"
PROJECT_ID="gcp-processing-vertex-prod-us"

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

# Asignar el rol Vertex AI User
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT" \
    --role="roles/iam.serviceAccountUser"

```

2. A nivel de la cuenta de servicio agregarle los siguientes permisos:
    - Visualizador de datos de BigQuery
    - Editor de datos de BigQuery
    - Usuario de trabajo de Bigquery
    - Visualizador de recursos de BigQuery
    - Usuario de sesión de lectura de BigQuery
    - Creador de objetos de Storage
    - Editor de Storage
    - Usuario de objetos de almacenamiento
    - Visualizador de objetos de Storage



## Permisos para Cuenta Servicio (sa-scheduler-scheduler-prod-01@gcp-processing-vertex-prod-us.iam.gserviceaccount.com)

1. A nivel del proyecto `gcp-processing-vertex-prod-us`:
    - Ejecutor de trabajos de Cloud Run
    - Invocador de Cloud Run


## Permisos para Cuenta Servicio (sa-crun-crun-prod-01@gcp-processing-vertex-prod-us.iam.gserviceaccount.com)

1. A nivel del proyecto `gcp-processing-vertex-prod-us`:
    - Ejecutor de trabajos de Cloud Run
    - Usuario de Agent Platform
    - Lector de Artifact Registry
    - Usuario de trabajo de BigQuery.
    
## Impersonalzicion de SA de Scheduler a Cloud Run 

    - Usuario de cuenta de servicio.
    - Creador de tokens de identidad de OpenID Connect para cuentas de servicio

## Impersonalzicion de SA de Cloud Run a Vertex 

    - Usuario de cuenta de servicio.