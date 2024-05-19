# s3-lambda-python-docker-terraform


Roadmap:

- Criar um repositório no s3
- Criar um user-lambda
    - iam
    - policies
- Adicionar um csv fake lá
- Criar um lambda com python
    - que leia o arquivo do s3 com polars e transforma pro pandas
    - e gera uma coluna com o numpy.random
    - funcionará como uma base para qualquer pipeline de dados
- Montar a imagem docker
- Testar o docker rodando localmente
- Criar um repositório no ecr
- Subir a imagem no repositório ecr
- Criar no terraform o lambda correspondente
- Adicionar o trigger de um novo arquivo do s3 no diretório
- Mudar o lambda para consumir baseado em um evento do s3
- E voi lá


How to export a python lib to be used as a custom layer:
pip install httpx -t httpx-layer/python/lib/python3.10/site-packages

Refs:
- https://medium.com/@haissamhammoudfawaz/create-a-aws-lambda-function-using-terraform-and-python-4e0c2816753a
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment