from scipy import constants
import polars as pl
import s3fs

bucket = "s3-lambda-python-docker-terraform-input-data"
file_key = "amazon_prime_users.csv"
fs = s3fs.S3FileSystem()

def lambda_handler(event, context):
    df = pl.read_csv(f"s3://{bucket}/{file_key}")
    df = df.with_columns(pl.lit(constants.Avogadro).alias("scipy_column"))
    print("Event:")
    print(event)

    print("Dataframe")
    print(df)


    destination = f"s3://{bucket}/processed/{file_key.split(".")[0]}.parquet"

    with fs.open(destination, mode="wb") as f:
        df.write_parquet(f)

    return {
        'statusCode':200,
        'fileSaved':destination
    }


if __name__ == "__main__":
    print(lambda_handler("","picanha"))