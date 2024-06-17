## IAC - Projeto ADA Modulo 5

O projeto tem como objetivo implementar (CI/CD) duas aplicações (console) e 3 serviços (cache, armazenamento e filas) no EKS da AWS, utilizando IaC.


# Ferramentas 

> As ferramentas utilizada são:
  
>
- ### [GitHub](https://github.com/)
- ### [GitHub Actions ](https://github.com/features/actions)
- ### [Sonarqube](https://www.sonarsource.com/products/sonarqube/)
- ### [Terraform](https://www.terraform.io/)
- ### [AWS EKS](https://aws.amazon.com/)
- ### [Kubernetes](https://kubernetes.io/)
- ### [Docker Hub](https://hub.docker.com/)
- ### [.NET](https://dotnet.microsoft.com/pt-br/)
- ### [VSCODE](https://code.visualstudio.com/)

# Configuração:
- Criar contas no GitHub, Sonarqube, AWS, Docker Hub
- Criar repositorios Github e Docker Hub(acesso público)
- Criar no repositorio GitHub as variaveis secrets:
- -> AWS_ACCESS_KEY_ID

- -> AWS_BUCKET_KEY

- -> AWS_BUCKET_NAME

- -> AWS_SECRET_ACCESS_KEY

- -> DOCKERHUB_TOKEN

- -> DOCKERHUB_USERNAME
 
- -> SONAR_TOKEN

- -> DOCKERHUB_REPOSITORY

- -> DOCKERHUB_TAG_SEND

- -> DOCKERHUB_TAG_RECEIVED

- Configuração:
- - Instalar e configurar o Terraform
- - criar um bucket na AWS S3, inserir o nome na secret AWS_BUCKET_NAME, o nome do arquivo terraform.tfstate deve ser incluido na secret AWS_BUCKET_KEY
- - Fazer o download dos arquivos do repositorio ou realizar o clone
- - Cadastrar no repositorio do Github, as variaveis do tipo secret listadas anteriormente. Inserir os dados de acesso a conta AWS nas secret, as demais informações das configurações desejaveis no terraform.tfvars e reforçando que as informações sensiveis (usuarios, senhas, tokens) devem ser cadastradas nas secrets
- - informar nos arquivos (5-received.yaml, 6-send.yaml) no diretorio src_app, o nome do repositorio e tag fornecidos nas secrets do Docker Hub
- - cadastrar no sonarqube o repositorio do GitHub que sera utilizado
- - atualizar o script  no arquivo deploy-app-ci-cd.yml, job do sonarqube conforme informaçoes e dados fornecidos na conta do sonarqube.

# Workflows
- Terraform IaC-CI-CD-AWS full - realizara todo o processo de criação da infra estrutura e deploy (*a imagem ja deve existir no repositorio docker hub) das aplicações e serviços dentro da AWS.
- Terraform destroy - remove todo o ambiente criado anteriomente.
- CI/CD - Build - Push - Deploy - realiza o build , testes, push no docker hub e deploy das aplicações e serviços
- CI/CD - Deploy - realiza o deploy das aplicações e serviços
- Get Logs by Pods-AWS - lista os logs dos pods informados no input

