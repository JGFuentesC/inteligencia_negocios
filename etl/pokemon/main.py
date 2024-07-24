import requests
from glom import glom 
import pandas as pd
from google.cloud import bigquery

def consultarPokemon(num:int)->dict:
    url = f"https://pokeapi.co/api/v2/pokemon/{num}"
    response = requests.get(url)
    data = response.json()
    return data

def parsePokemon(data:dict)->pd.DataFrame:
    claves = ['height',
    'id',
    'sprites.other.official-artwork.front_default',
    'stats',
    'weight',
    'name']
    data = pd.Series(dict(zip(claves, map(lambda k:glom(data,k),claves))))
    data = data.to_frame().T
    def splitStats(stats:list)->tuple:
        return {glom(st,'stat.name'):glom(st,'base_stat') for st in stats}
    data['stats'] = data['stats'].map(splitStats) 
    return pd.concat([data.drop('stats',axis=1),data['stats'].apply(pd.Series)],axis=1)

def writeDataFrameToBigQuery(dataframe, project_id, dataset_id, table_id):
    client = bigquery.Client(project=project_id)
    dataset_ref = client.dataset(dataset_id)
    table_ref = dataset_ref.table(table_id)

    job_config = bigquery.LoadJobConfig()
    job_config.write_disposition = bigquery.WriteDisposition.WRITE_APPEND
    job_config.autodetect = True

    job = client.load_table_from_dataframe(dataframe, table_ref, job_config=job_config)
    job.result()

def etlPokemon(request):
    try:
        print("Extrayendo pokemon...")
        num = request.args.get('num')
        print("Transformando datos...")
        data = parsePokemon(consultarPokemon(num))
        print("Cargando datos...")
        writeDataFrameToBigQuery(data,'anahuac-bi','pokemon','stats')
        return 200, "Todo Ok!"
    except Exception as e:
        return 500, str(e)