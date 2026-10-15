# 0004 — Back e front conversam por contrato e por sub-issue

**Status:** Aceita · 15/10/2026

## Contexto

A API escreve `docs/flutter/handoff-0.1x.md` com código Dart; o app escreve `docs/back/HANDOFF.md` e um arquivo datado por pedido. Os dois lados mantêm o mesmo payload à mão, e o estado de cada pedido vive num Markdown.

## Decisão

- O contrato de rota tem um dono: o repo do back (`docs/api/<modulo>.md`), escrito antes do código.
- O pedido do app ao back é uma sub-issue no Linear, no projeto do back.
- O app linka o contrato e documenta só o que é dele.

Procedimento: skill `contrato-api`.

## Alternativas descartadas

- **Handoff em Markdown nos dois repos:** o estado atual.
- **OpenAPI gerado como única fonte:** bom para o formato, mas não carrega regra nem erro de negócio. Pode complementar o `docs/api/`.

## Consequências

- `docs/back/` do app e `docs/flutter/handoff-*` da API são aposentados.
- O status do pedido é o status da sub-issue.
