import polars as pl
import s3fs

# bucket = "s3-lambda-python-docker-terraform-input-data"
# file_key = "amazon_prime_users.csv"
fs = s3fs.S3FileSystem()

def lambda_handler(event, context):
    try:
        bucket = event['Records'][0]['s3']['bucket']['name']
        file_key = event['Records'][0]['s3']['object']['key']
    except:
        return {
            'statusCode':404,
            'errorReason':"unable to find file"
        }
    
    df = pl.read_csv(f"s3://{bucket}/{file_key}")
    df = df.with_columns(pl.lit(4).alias("scipy_column"))
    destination = f"s3://{bucket}/processed/{file_key.split('.')[0]}.parquet"

    with fs.open(destination, mode="wb") as f:
        df.write_parquet(f)

    return {
        'statusCode':200,
        'fileSaved':destination
    }


if __name__ == "__main__":
    print(lambda_handler("","picanha"))