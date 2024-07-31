import requests
from glom import glom 
import pandas as pd
from flask import jsonify
from google.cloud import bigquery

def consultarPokemon(num:int)->dict:
    """
    Consulta la información de un Pokémon en la PokeAPI.

    Parámetros:
    - num (int): El número del Pokémon a consultar.

    Retorna:
    - dict: Un diccionario con la información del Pokémon consultado.
    """
    url = f"http://pokeapi.co/api/v2/pokemon/{num}"
    response = requests.get(url)
    print(response.status_code,url)
    data = response.json()
    return data

def parsePokemon(data:dict)->pd.DataFrame:
    """
    Función que recibe un diccionario de datos de un Pokémon y devuelve un DataFrame con los datos procesados.

    Parámetros:
    - data (dict): Diccionario con los datos del Pokémon.

    Retorna:
    - pd.DataFrame: DataFrame con los datos procesados del Pokémon.
    """
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
    data = pd.concat([data.drop('stats',axis=1),data['stats'].apply(pd.Series)],axis=1)
    data.rename(columns={'sprites.other.official-artwork.front_default':'image_url'},inplace=True)
    return data

def writeDataFrameToBigQuery(dataframe, project_id, dataset_id, table_id):
    """
    Escribe un DataFrame en BigQuery.

    Parámetros:
    - dataframe: El DataFrame que se desea escribir en BigQuery.
    - project_id: El ID del proyecto de BigQuery.
    - dataset_id: El ID del dataset de BigQuery.
    - table_id: El ID de la tabla de BigQuery.

    """
    client = bigquery.Client(project=project_id)
    dataset_ref = client.dataset(dataset_id)
    table_ref = dataset_ref.table(table_id)

    job_config = bigquery.LoadJobConfig()
    job_config.write_disposition = bigquery.WriteDisposition.WRITE_APPEND
    job_config.autodetect = True

    job = client.load_table_from_dataframe(dataframe, table_ref, job_config=job_config)
    job.result()

def etlPokemon(request):
    """
    Realiza el proceso de extracción, transformación y carga (ETL) de datos de un Pokémon.

    Args:
        request (object): El objeto de solicitud HTTP.

    Returns:
        object: El objeto de respuesta HTTP con el estado y mensaje correspondientes.
    """
    try:
        request_json = request.get_json()
        if 'num' not in request_json:
            return 'Missing parameter: num', 400
        else:
            num = request_json['num']
            print("Extrayendo pokemon...")
            data = consultarPokemon(num)
            print("Transformando datos...")
            data = parsePokemon(data)
            print("Cargando datos...")
            writeDataFrameToBigQuery(data,'anahuac-bi','pokemon','stats')
            return jsonify({"status":"OK","message":"Pokemon cargado correctamente","data":data.to_dict()}),200
    except Exception as e:
        print(str(e))
        return jsonify({"status":"ERROR", "message":str(e)}),500