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

## Comandos

```bash
make setup   # primeira vez
make gen     # codegen
make check   # o gate: format + analyze + arquitetura + testes
```

## Armadilhas

<Só o que a inferência erraria. Ex.: "não há use cases; notifier chama repository direto".>

## Linear

Projeto: <nome> · Label de repositório: <LABEL> · Tarefa central atual: <MAT-n>
