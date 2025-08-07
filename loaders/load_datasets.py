import duckdb
import pandas as pd
from pathlib import Path


data_path = Path("data/raw")
con = duckdb.connect("olist.duckdb")
con.execute("CREATE SCHEMA IF NOT EXISTS bronze;")

for file in data_path.glob("*.csv"):
    entity = file.name.replace("olist_", "").replace("_dataset.csv", "")
    table_name = f"{entity}_raw"
    print(f"Loading {file.name} to {table_name}")
    df = pd.read_csv(file)
    con.execute(f'DROP TABLE IF EXISTS "bronze"."{table_name}";')
    con.execute(f'CREATE TABLE "bronze"."{table_name}" AS SELECT * FROM df;')
con.close()