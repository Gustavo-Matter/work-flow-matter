# 0003 — Fonte única para cada informação, e doc com tamanho máximo

**Status:** Aceita · 15/10/2026

## Contexto

No muma-fit-api, uma feature toca 7–8 arquivos de doc, e a mesma rota aparece em ADR, `api.md`, flow, handoff do Flutter e CHANGELOG. As cópias divergem e geram commits `docs: align/clarify`. Arquivos de 86–108 KB não cabem numa leitura, então a IA lê pedaços e escreve inconsistências.

## Decisão

- Cada informação tem um lugar (tabela da regra 3 em [workflow.md](../workflow.md)); os outros documentos **linkam**.
- Doc passa de ~25 KB: quebra por módulo ou sub-fluxo.

## Alternativas descartadas

- **Gerar a doc toda a partir do código:** cobre contrato, não cobre decisão nem fluxo.
- **Manter as cópias com um checklist de sincronização:** é o que já acontece, e falha.

## Consequências

- `api.md` e `domain.md` grandes viram `docs/api/<modulo>.md`.
- O app deixa de copiar payload; o back deixa de escrever código Dart.
- O `pronto` confere tamanho e duplicação antes do commit.
