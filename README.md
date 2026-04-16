# tf-eks-gitops-karpenter

Infraestrutura e aplicação de exemplo para Kubernetes na AWS com foco em:

- Provisionamento de rede e EKS com Terraform
- Repositórios ECR para imagens de frontend e backend
- Aplicação full stack (Next.js + ASP.NET Core)
- Base para fluxo GitOps e uso de Karpenter (ainda não implementado neste repositório)


## Aplicação

### Backend (`app/backend/YoutubeLiveApp`)

- API ASP.NET Core com endpoint de saúde e endpoint de exemplo (`WeatherForecast`)
- `Program.cs` publica as rotas sob prefixo `/backend`
- Dockerfile multi-stage para build e runtime em .NET 8

### Frontend (`app/frontend/youtube-live-app`)

- Projeto Next.js 14 inicial (template padrão)
- Dockerfile multi-stage com build e execução via `npm start`


## Visão geral da arquitetura

O projeto está organizado em três camadas principais de infraestrutura e uma camada de aplicação:

1. `remote-backend/`: cria bucket S3 para `terraform remote state` com lock e versionamento configurado. 
2. `networking/`: cria VPC, subnets públicas/privadas, IGW, NAT e rotas.
3. `eks/`: cria cluster EKS, node group gerenciado e repositórios ECR.
4. `app/`: contém backend ASP.NET Core e frontend Next.js para empacotamento em containers.


## Flowchart do projeto

```mermaid
flowchart TD
    subgraph Terraform Infra
        A["remote-backend<br/>(S3 Remote State + Lock)"]
        B["networking<br/>(VPC, Public/Private Subnets,<br/>IGW, NAT, Route Tables)"]
        C["eks<br/>(EKS Cluster + Managed Node Group)"]
        D["ECR Repositories<br/>(app/backend + app/front)"]

        A --> B --> C --> D
    end

    subgraph Application
        E["Backend<br/>(ASP.NET Core .NET 8)"]
        F["Frontend<br/>(Next.js 14)"]
        G["Docker Build Backend"]
        H["Docker Build Frontend"]

        E --> G
        F --> H
    end

    subgraph Kubernetes Runtime
        I["Kubernetes Deployments"]
        J["Backend Pods"]
        K["Frontend Pods"]

        I --> J
        I --> K
    end

    G --> D
    H --> D
    D --> I
    C --> I
```

## Estrutura do repositório

```txt
.
├── app/
│   ├── backend/YoutubeLiveApp/           # API ASP.NET Core (.NET 8)
│   └── frontend/youtube-live-app/        # Frontend Next.js 14
├── eks/                                  # Terraform do cluster EKS e ECR
├── networking/                           # Terraform de VPC/subnets/rotas
└── remote-backend/                       # Terraform do bucket S3 de estado remoto
```

## Stack utilizada

- Terraform 
- AWS
- .NET 8 (backend)
- Node.js 21 + Next.js 14 (frontend)
- Docker (build local de imagens)

## Pré-requisitos

- Conta AWS com permissões para VPC, EKS, IAM, ECR e S3
- AWS CLI configurada localmente
- Perfil AWS 
- Terraform instalado
- Docker instalado (se for testar build das imagens)
- `kubectl` (para operar o cluster após provisionamento)

## Ordem recomendada de provisionamento

> Este projeto usa `remote state` em S3 nos diretórios `networking/` e `eks/`.

1. Criar backend remoto:

```bash
cd remote-backend
terraform init
terraform apply
```

2. Provisionar rede:

```bash
cd ../networking
terraform init
terraform plan
terraform apply
```

3. Provisionar EKS e ECR:

```bash
cd ../eks
terraform init
terraform plan
terraform apply
```

## Próximos passos recomendados

- Integração do Karpenter para autoscaling inteligente de nós

Projeto derivado da Imersão Devops Na Nuvem do Kenerry Serain.

Continuação no repo [GitOps](https://github.com/RildoDias08/GitOps).