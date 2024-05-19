import httpx


def lambda_handler(event, context):

    finding_google = httpx.get("https://www.google.com/")

    return {
        'statusCode':200,
        'googleStatus':f"Google Answer: {finding_google.status_code}"
    }


if __name__ == "__main__":
    print(lambda_handler("chorizo","picanha"))