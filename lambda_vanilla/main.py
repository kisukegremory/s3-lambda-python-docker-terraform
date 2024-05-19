import boto3


session = boto3.Session()
s3 = session.client("s3")

def lambda_handler(event, context):
    s3_obj = s3.get_object(
        Bucket="s3-lambda-python-docker-terraform-input-data",
        Key="input-data.csv"
    )

    return {
        'statusCode':200,
        'lastModified': str(s3_obj['LastModified'])
    }

if __name__ == "__main__":
    print(lambda_handler("batata","salada"))