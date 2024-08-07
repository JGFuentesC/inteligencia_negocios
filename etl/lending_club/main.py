from auxiliares import Loan
from google.cloud import storage
import functions_framework
import os

@functions_framework.cloud_event
def process_file(cloud_event):
    try:
        data = cloud_event.data
        bucket_name = data['bucket']
        file_name = data['name']
        if 'raw' not in file_name:
            print("File is not a raw file")
        else:
            print(f"Processing file: gs://{bucket_name}/{file_name}")
            
            print("Leyendo archivo...")
            # Read the file from GCS
            client = storage.Client()
            bucket = client.get_bucket(bucket_name)
            blob = bucket.blob(file_name)
            id = file_name.split('/')[-1].split('.')[0]
            file_content = blob.download_to_filename(f'/tmp/{id}.json')
            print("Procesando archivo...")
            # Process the file
            loan = Loan(f'/tmp/{id}.json')
            loan.toParquet('/tmp')
        
            print("Cargando archivo...")
            # Upload the processed file back to GCS
            processed_blob = bucket.blob(os.path.join('curated',f'processed_{loan.id}.parquet'))
            processed_blob.upload_from_filename(f'/tmp/{loan.id}.parquet')
            
            return "File processed successfully"
    except Exception as e:
        print(str(e))
        return str(e)