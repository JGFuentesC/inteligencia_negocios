gcloud functions deploy etl-loans \
  --runtime python311 \
  --gen2 \
  --max-instances=1 \
  --region=us-central1 \
  --source=. \
  --memory 512MB \
  --trigger-resource loans_anahuac \
  --trigger-event google.storage.object.finalize \
  --service-account etl-anahuac@anahuac-bi.iam.gserviceaccount.com \
  --entry-point process_file

