# <nome-do-repo> — API

<Uma frase: o que a API serve e para quem.> .NET <versão> / ASP.NET Core, <banco> + <ORM>. Workflow da Matter: plugin `matter-workflow` (skills `feature-back`, `pronto`).

**Este arquivo é índice.** Arquitetura em [docs/architecture.md](docs/architecture.md), convenções em [docs/conventions.md](docs/conventions.md), contrato por módulo em [docs/api/](docs/api/), decisões em [docs/adr/](docs/adr/).

## Comandos

```bash
dotnet build <Solution> -c Release   # zero avisos
dotnet test <Projeto.Tests>
```

<Pré-requisitos para rodar: secrets, Docker, porta.>

## Deploy

<Onde roda e o que dispara o deploy (ex.: push na main → GitHub Actions → ECR → EC2). Branch base dos PRs.>

## Armadilhas

<Só o que um agente inferiria errado lendo o código. Ex.: "v1 tem formato congelado; mudanças só na v2".>

## Linear

Projeto: <nome> · Label de repositório: <LABEL> · Tarefa central atual: <MAT-n>
