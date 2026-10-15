# 0002 — Um PR por sub-issue

**Status:** Aceita · 15/10/2026 · Substitui a convenção "um PR por plano" da skill `linear-tarefa`

## Contexto

Com "um PR por plano", a branch `docs/planejamento-features` do bencaodiaria-app-api chegou a 33 commits, 214 arquivos e ~18 mil linhas. Ninguém revisa isso, e a IA não segura o diff no contexto.

## Decisão

Cada sub-issue tem sua branch (`tipo/mat-<n>-descricao`) e seu PR, com código, testes e a doc daquela entrega. A tarefa central junta os PRs. Meta: até ~15 arquivos de código por PR, fora gerados e migrations.

## Alternativas descartadas

- **PR por plano:** o problema acima.
- **PR por fase:** aceitável quando a fase é pequena, mas "fase" não tem tamanho definido; sub-issue tem critério de pronto.

## Consequências

- O plano precisa quebrar o trabalho em sub-issues entregáveis sozinhas (skill `planejar-feature`).
- Doc não vira sub-issue: vai no PR do código que descreve.
