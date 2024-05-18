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