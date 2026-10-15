---
name: feature-back
description: Use ao implementar ou alterar rota, regra de negócio ou persistência numa API .NET da Matter (muma-fit-api, bencaodiaria-app-api ou nova). Traz as regras de camada, envelope, erros, logs, testes e o que documentar.
---

# feature-back (.NET)

O CLAUDE.md do repo e a doc do módulo têm prioridade quando forem mais específicos que esta skill. Os princípios comuns a todas as stacks (estrutura, fluxo, envelope, logs) estão na skill `padroes-codigo`; aqui está a aplicação deles em .NET.

## Antes de codar

1. Leia o CLAUDE.md do repo, a doc do módulo (`docs/api/<modulo>.md` ou a seção dele) e os ADRs que ela cita. Só esses.
2. Ache um módulo vizinho que já faz algo parecido e siga o formato dele.

## Regras

- **Por domínio:** `Modules/<Dominio>/` com controller, service, repository, schemas. Módulo não importa outro; o que é compartilhado vai para `Shared/`. Dependência externa (banco, HTTP, SDK) fica isolada em `Infra/`.
- **Fluxo:** `controller → service → repository`.
  - Controller: recebe o DTO já validado (DataAnnotations/FluentValidation), chama o service, devolve o envelope. Sem regra e sem banco.
  - Service: regra de negócio, sem nada de HTTP (lança exceção de domínio, o middleware mapeia o status).
  - Repository: query e persistência, sem regra.
- **Envelope:** toda rota nova devolve `{ transactionId (nanoid), message, data?, error? }`. Erro com código estável quando o repo já tem códigos.
- **Logs:** estruturado (Serilog compact JSON), com `requestId`. Nunca senha, token ou payload grande.
- **Comentários:** no máximo 1 a 2 linhas, só com o porquê; nunca narrando a linha seguinte. Não cabe em duas linhas: vira ADR ou doc. Sem `///` XML doc em código novo, a não ser que o repo exija para o Swagger (bencaodiaria-app-api hoje exige), e ainda assim em 1 a 2 linhas.
- **Migrations:** uma por mudança de schema, com `Down` correto.

## Checklist da stack (o `pronto` cobra)

- [ ] Concorrência: contador e saldo atualizam de forma atômica (`UPDATE ... SET x = x + 1` ou `ExecuteUpdate`), nunca ler-somar-salvar.
- [ ] Autorização: quem chama tem direito ao recurso (dono, membro ativo, admin)? Testado com outro usuário.
- [ ] Dados do usuário: exclusão de conta/anonimização cobre a tabela nova?
- [ ] Fuso e datas: "dia" é o dia no fuso do usuário; períodos com início e fim (`EndsOn`) respeitados.
- [ ] Paginação e limites: cursor/offset sem overflow, tamanho máximo, entrada vazia.
- [ ] Validação de entrada com resposta 400/422 no envelope; recurso inexistente é 404.
- [ ] Teste de unidade da regra + teste de integração da rota (caminho feliz e os erros acima).
- [ ] `dotnet build` sem aviso e `dotnet test` verde.

## Doc no mesmo PR

- Rota nova ou alterada: contrato em `docs/api/<modulo>.md` (ou na seção do módulo). Só ali.
- Decisão: skill `registrar-decisao` (ADR curto, sem payload).
- `CHANGELOG.md`: uma linha por mudança visível para o app.
- Diagrama de fluxo só quando há assincronia ou mais de dois serviços envolvidos.
- **Não** escreva handoff com código Dart: o app lê o contrato.
