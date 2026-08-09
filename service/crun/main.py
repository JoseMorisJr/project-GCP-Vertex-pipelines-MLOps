import os
from google.cloud import aiplatform
from datetime import datetime
import pytz
from uuid import uuid4
import json
import argparse

def run_pipeline(periodo: str):

    # Entornos
    pipeline_config = {
        # Proyecto
        "GCP_PROJECT_ID": os.environ["GCP_PROJECT_ID"],
        "GCP_BUCKET_NAME": os.environ["GCP_BUCKET_NAME"],
        "GCP_MODEL_PROJECT": os.environ["GCP_MODEL_PROJECT"],
        "MODEL_ROOT": os.environ["MODEL_ROOT"],
        "PIPELINE_ROOT": os.environ["PIPELINE_ROOT"],

        # Tables inputs
        "GCP_PROJECT_ID_INPUT": os.environ["GCP_PROJECT_ID_INPUT"],
        "BQ_DATASET_ID_INPUT": os.environ["BQ_DATASET_ID_INPUT"],
        "BQ_TABLE_ID_INPUT": os.environ["BQ_TABLE_ID_INPUT"],

        # Tables features
        "BQ_DATASET_ID_FEATURES": os.environ["BQ_DATASET_ID_FEATURES"],
        "BQ_TABLE_ID_FEATURES": os.environ["BQ_TABLE_ID_FEATURES"],

        # Tables temporales
        "BQ_DATASET_ID_TEMP": os.environ["BQ_DATASET_ID_TEMP"],
        "BQ_TABLE_ID_TEMP_DATA": os.environ["BQ_TABLE_ID_TEMP_DATA"],
        "BQ_TABLE_ID_TEMP_DATA_TRANSF": os.environ["BQ_TABLE_ID_TEMP_DATA_TRANSF"],
        "BQ_TABLE_ID_TEMP_DATA_PREDICT": os.environ["BQ_TABLE_ID_TEMP_DATA_PREDICT"],

        # Tablas Outputs
        "GCP_PROJECT_ID_OUT": os.environ["GCP_PROJECT_ID_OUT"],
        "BQ_DATASET_ID_OUT": os.environ["BQ_DATASET_ID_OUT"],
        "BQ_TABLE_ID_OUT": os.environ["BQ_TABLE_ID_OUT"],
        "BQ_TABLE_ID_OUT_HIST": os.environ["BQ_TABLE_ID_OUT_HIST"],

        # GSA
        "GSA_NAME":os.environ["GSA_NAME"] 
    }

    bucket_name = pipeline_config["GCP_BUCKET_NAME"]
    model_project = pipeline_config["GCP_MODEL_PROJECT"]
    project_id = pipeline_config["GCP_PROJECT_ID"]
    destination_blob_name = f"{model_project}/pipeline_end_to_end/pipeline-processing-predict.json"

    def generar_run_id() -> str:
        timestamp = datetime.now(pytz.utc).strftime("%Y%m%dT%H%M%SZ")
        token = uuid4().hex[:12]
        return f"house-price-{timestamp}-{token}"
 
    run_id = generar_run_id()

    # Inicializacion Pipeline
    aiplatform.init(project=project_id, location="us-central1")

    job = aiplatform.PipelineJob(
        display_name="pipeline-data-processing-predict",
        template_path=f"gs://{bucket_name}/{destination_blob_name}",
        enable_caching=False,
        project=project_id,
        location="us-central1",
        parameter_values={
                            "AAAAMM":periodo,
                            "run_id":run_id,
                            "config_json_t":json.dumps(pipeline_config)
                        },
        labels={"module": "ml", "application": "app", "chapter": "mlops", "environment": "prd", "owner": "jmorib"}
    )

    print('submit pipeline job ...')
    job.submit(service_account=pipeline_config["GSA_NAME"])

    print(
    json.dumps({
        "periodo": periodo,
        "run_id": run_id,
        "pipeline_job": job.resource_name,
    })
    )

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--periodo",
        required=True,
        help="Período en formato AAAAMM. Ejemplo: 202606.",
    )

    args = parser.parse_args()
    run_pipeline(args.periodo)