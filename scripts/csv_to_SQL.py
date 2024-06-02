import pandas as pd
from sqlalchemy import create_engine
import os

path = 'C:\\Users\\PC\\Documents\\Matias\\notebooks_specifications\\data'
csv_file = os.path.join(path, 'mindfactory_updated.csv')

POSTGRES_USER = 'root'
POSTGRES_PASSWORD = 'pg1234'
POSTGRES_DB = 'name_db'
POSTGRES_HOST = 'localhost'

connection_url = f'postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}/{POSTGRES_DB}'
engine = create_engine(connection_url)

if __name__ == '__main__':
    notebooks = pd.read_csv(csv_file)
    notebooks.to_sql('notebooks', con=engine, if_exists='replace', index=False)
    print("TABLE notebooks was saved successfully")
