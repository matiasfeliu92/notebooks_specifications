import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

load_dotenv()

path = 'C:\\Users\\PC\\Documents\\Matias\\notebooks_specifications\\data'
csv_file = os.path.join(path, 'mindfactory_updated.csv')
engine = None

def get_engine():
    POSTGRES_USER = 'root'
    POSTGRES_PASSWORD = 'pg1234'
    POSTGRES_DB = 'name_db'
    POSTGRES_HOST = 'localhost'
    connection_url = f'postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}/{POSTGRES_DB}'
    try:
        engine = create_engine(connection_url)
        with engine.connect() as connection:
            print("Conexión local exitosa")
            return engine
    except Exception as e:
        print(f"Conexión local fallida: {e}")
        try:
            database_url = os.getenv('DATABASE_URL')
            engine = create_engine(database_url)
            with engine.connect() as connection:
                print("Conexión remota exitosa")
                return engine
        except Exception as e:
            print(f"Conexión remota fallida: {e}")
            return None

engine = get_engine()
if engine is not None:
    print(f"Conexión establecida con éxito: {engine.url}")
else:
    print("No se pudo establecer ninguna conexión")

if __name__ == '__main__':
    notebooks = pd.read_csv(csv_file)
    notebooks.to_sql('notebooks', con=engine, if_exists='replace', index=False)
    print("TABLE notebooks was saved successfully")