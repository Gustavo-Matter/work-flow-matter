# 0006 — A revisão acontece antes do commit

**Status:** Aceita · 15/10/2026

## Contexto

Nos quatro repos, quase todo `feat` tem um `fix` logo atrás (muma-fit app: 84 `fix` para 110 `feat`; bencao mobile: 64 para 39). Cada `fix` é uma segunda rodada inteira: reler o código, corrigir, reescrever a doc. Os defeitos se repetem: atomicidade, autorização, fuso, estados de tela, fidelidade ao Figma.

## Decisão

A skill `pronto` roda antes do primeiro commit da feature: gate do repo, checklist da stack (`feature-back`/`feature-front`) e o agente `revisor` sobre o diff. O que for confirmado entra no mesmo commit.

## Alternativas descartadas

- **Revisão só no PR:** é o estado atual; o achado vira `fix(review)`.
- **Revisor genérico sem checklist:** acha estilo, não os defeitos que de fato se repetem aqui.

## Consequências

- O checklist de cada skill de stack é a lista dos defeitos reais encontrados no git. Defeito novo que se repete entra no checklist e no `revisor`.
