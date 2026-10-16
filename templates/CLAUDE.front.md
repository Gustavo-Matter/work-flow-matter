# <nome-do-repo> — app Flutter

<Uma frase: o que o app faz.> Flutter <versão> via FVM. Workflow da Matter: plugin `matter-workflow` (skills `feature-front`, `pronto`, `contrato-api`).

**Este arquivo é índice.** Comece por [docs/README.md](docs/README.md). Feature: `docs/features/<nome>.md`. Decisões: [docs/decisions/](docs/decisions/). Contrato da API: `<repo-do-back>/docs/api/`.

## Stack

| Camada | Tecnologia |
|---|---|
| Estado | <Riverpod / Cubit> |
| Navegação | <go_router / rotas nomeadas> |
| HTTP | <dio via matter_core> |
| Erro | <Either<Failure, T> / AppFailure> |
| Design system | <matter_design_system / tokens locais> |
| Imagem de rede | <MatterNetworkImage / AppNetworkImage> |
| Teste | `mocktail` (ADR-0012 do workflow) |
| l10n | <não há / ARB pt, en, es> |
| Tema | <só claro / claro e escuro> |
| Kit | <matter_core core-vX.Y.Z · matter_design_system design_system-vX.Y.Z / não usa> |

## Comandos

```bash
make setup   # primeira vez
make gen     # codegen
make check   # o gate: format + analyze + arquitetura + testes
```

<CI: ligado / pausado (o gate é só local).> Prefira o LSP a grep para achar definição e referência.

## Armadilhas

<Só o que a inferência erraria. Ex.: "não há use cases; notifier chama repository direto".>

## Linear

Projeto: <nome> · Label de repositório: <LABEL> · Tarefa central atual: <MAT-n>
